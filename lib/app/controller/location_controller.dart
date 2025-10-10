import 'package:falangthai/app/controller/user_controller.dart';
// import 'package:falangthai/app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationController extends GetxController {
  RxBool isloading = false.obs;
  // RxBool get isLocation => _isLocation;
  Location location = Location();

  Future<void> getCurrentCity({VoidCallback? nextScreen}) async {
    isloading.value = true;
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
      }
      LocationData locationData = await location.getLocation();
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        locationData.latitude ?? 0.0,
        locationData.longitude ?? 0.0,
      );
      String? city = placemarks[0].subAdministrativeArea;
      if (city == null || city.isEmpty) return;
      final userController = Get.find<UserController>();
      await userController.updateLocation(
        latitude: locationData.latitude ?? 0.0,
        longitude: locationData.longitude ?? 0.0,
        address: city,
        nextScreen: nextScreen,
      );

    } catch (e, stackTrace) {
      debugPrint("${e.toString()} StackTrace: $stackTrace");
    } finally {
      isloading.value = false;
    }
  }
}
