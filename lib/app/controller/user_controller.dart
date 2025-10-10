import 'dart:convert';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/data/services/user_service.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _userService = UserService();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  final isloading = false.obs;

  Future<void> getUserDetails() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserDetails(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (message == "Token has expired.") {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      if (response.statusCode != 200) {
        // CustomSnackbar.showErrorToast(message);
        return;
      }

      var userData = decoded["data"];
      UserModel mapped = UserModel.fromJson(userData);
      userModel.value = mapped;
      userModel.refresh();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateGender({
    required String gender,
    VoidCallback? nextScreen,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return;
      }

      final response = await _userService.updateGender(
        token: token,
        gender: gender,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      if (nextScreen != null) {
        nextScreen();
        return;
      }
      // final locationController = Get.find<LocationController>();
      // await locationController.getCurrentCity();
      Get.toNamed(AppRoutes.locationRequest);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateLocation({
    required double latitude,
    required double longitude,
    required String address,
    VoidCallback? nextScreen,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return;
      }

      final response = await _userService.updateLocation(
        token: token,
        latitude: latitude,
        longitude: longitude,
        address: address,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      if (nextScreen != null) {
        nextScreen();
        return;
      }
      Get.toNamed(AppRoutes.profileUpload);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
