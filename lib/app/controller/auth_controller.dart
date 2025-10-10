import 'dart:convert';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/data/services/auth_service.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final isloading = false.obs;
  final isOtpVerifyLoading = false.obs;
  final _authService = AuthService();

  Future<void> loginUser({
    required String identifier,
    required String password,
  }) async {
    isloading.value = true;
    try {
      final response = await _authService.loginUser(
        identifier: identifier,
        password: password,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      String token = decoded["token"] ?? "";
      final storageController = Get.find<StorageController>();
      await storageController.storeToken(token);

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      // final userController = Get.find<UserController>();
      // final storyController = Get.find<StoryController>();
      // await userController.getUserDetails();
      // await userController.getPotentialMatches();
      // await storyController.getAllStories();
      // await storyController.getUserPostedStories();
      Get.offAllNamed(AppRoutes.bottomNavigation);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> signUpUSer({required UserModel userModel}) async {
    isloading.value = true;
    try {
      final response = await _authService.signUpUser(userModel: userModel);
      if (response == null) return;
      final decoded = json.decode(response.body);
      var message = decoded["message"] ?? "";
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final userController = Get.find<UserController>();
      final storageController = Get.find<StorageController>();
      String token = decoded["token"];
      await storageController.storeToken(token);
      // final socketController = Get.find<SocketController>();
      // socketController.initializeSocket();
      await userController.getUserDetails();
      Get.offAllNamed(
        AppRoutes.otpVerification,
        arguments: {"email": userModel.email},
      );
    } catch (e) {
      debugPrint("Error From Auth Controller: ${e.toString()}");
    } finally {
      isloading.value = false;
    }
  }

  Future<void> changeAuthDetails({String? email, String? phoneNumber}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null) return;
      final response = await _authService.changeAuthDetails(
        token: token,
        email: email,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      // final usercontroller = Get.find<UserController>();
      // await usercontroller.getUserDetails();
      CustomSnackbar.showSuccessToast(message);
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> verifyOtp({
    required String otpCode,
    required String email,
    VoidCallback? whatNext,
  }) async {
    isOtpVerifyLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _authService.verifyOtp(
        otpCode: otpCode,
        email: email,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      if (whatNext != null) {
        whatNext();
        return;
      }

      Get.offNamed(AppRoutes.gender);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isOtpVerifyLoading.value = false;
    }
  }

  Future<void> sendOtp({required String email}) async {
    isloading.value = true;
    try {
      final response = await _authService.sendOtp(email: email);
      if (response == null) return;

      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast("Failed to get OTP, $message");
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
