import 'dart:async';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> getCurrentCity({VoidCallback? nextScreen}) async {
    isloading.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // User permanently denied permission
        await Geolocator.openAppSettings();
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 15),
        ),
      );

      final placemarks = await geo.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String? city = placemarks[0].subAdministrativeArea;
      if (city == null || city.isEmpty) return;
      final userController = Get.find<UserController>();
      await userController.updateLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: city,
        nextScreen: nextScreen,
      );
    } on TimeoutException catch (e) {
      debugPrint("TimeoutException: $e");
    } catch (e, stackTrace) {
      debugPrint("${e.toString()} StackTrace: $stackTrace");
    } finally {
      isloading.value = false;
    }
  }

}
