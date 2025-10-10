import 'dart:convert';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/data/services/auth_service.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final isloading = false.obs;
  final _authService = AuthService();

  Future<void> loginUser({
    required String identifier,
    required String password,
  }) async {
    isloading.value = true;
    // final loginController = Get.find<LoginController>();
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
      if (response.statusCode == 404) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      if (response.statusCode == 402) {
        CustomSnackbar.showErrorSnackBar(message);
        // Get.offAll(() => const RegisterScreen());
        return;
      }
      // final socketController = Get.find<SocketController>();
      // await socketController.initializeSocket();
      if (response.statusCode == 401) {
        CustomSnackbar.showErrorSnackBar(message);
        return;
      }
      if (response.statusCode == 400) {
        CustomSnackbar.showErrorSnackBar(message);
        // Get.offAll(() => CompleteProfileScreen());
        return;
      }
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorSnackBar(message);
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
}
