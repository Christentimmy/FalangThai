import 'dart:convert';
import 'dart:io';
import 'package:falangthai/app/controller/invite_controller.dart';
import 'package:falangthai/app/controller/message_controller.dart';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/subscription_controller.dart';
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

  Future<void> googleAuthSignUp() async {
    isloading.value = true;
    try {
      final idToken = await _authService.signInWithGoogle();
      if (idToken == null) {
        return;
      }
      final response = await _authService.sendGoogleToken(
        token: idToken,
        isRegister: true,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final userController = Get.find<UserController>();
      final storageController = Get.find<StorageController>();
      String token = decoded["token"] ?? "";
      if (token.isEmpty) return;
      await storageController.storeToken(token);
      // final socketController = Get.find<SocketController>();
      // socketController.initializeSocket();
      await userController.getUserDetails();
      Get.toNamed(AppRoutes.gender);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> googleAuthSignIn() async {
    isloading.value = true;
    try {
      final idToken = await _authService.signInWithGoogle();
      if (idToken == null) {
        CustomSnackbar.showErrorToast("Failed to sign in with Google");
        return;
      }

      final response = await _authService.sendGoogleToken(
        token: idToken,
        isRegister: false,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);

      String message = decoded["message"] ?? "";
      String token = decoded["token"] ?? "";
      if (token.isEmpty) return;

      final storageController = Get.find<StorageController>();
      await storageController.storeToken(token);

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final userController = Get.find<UserController>();
      await userController.getUserDetails();
      Get.offAllNamed(AppRoutes.bottomNavigation);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    isloading.value = true;
    try {
      final response = await _authService.loginUser(
        email: email,
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
      final userController = Get.find<UserController>();
      // final storyController = Get.find<StoryController>();
      await userController.getUserDetails();
      // await userController.getPotentialMatches();
      // await storyController.getAllStories();
      // await storyController.getUserPostedStories();
      // Get.offAllNamed(AppRoutes.bottomNavigation);
      await handleLoginNavigation();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> handleLoginNavigation() async {
    final userController = Get.find<UserController>();
    await userController.getUserDetails();
    final user = userController.userModel.value;

    if (user == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    if (user.profileCompleted == true) {
      Get.offAllNamed(AppRoutes.bottomNavigation);
      return;
    }
    if (user.isEmailVerified == false) {
      if (user.email?.isEmpty == true) return;
      await sendOtp(email: user.email!);
      Get.offAllNamed(
        AppRoutes.otpVerification,
        arguments: {
          "email": user.email,
          "showEditDetails": true,
          "onVerifiedCallBack": () async {
            await handleLoginNavigation();
          },
        },
      );
      return;
    }
    if (user.gender?.isEmpty == true) {
      Get.offAllNamed(
        AppRoutes.gender,
        arguments: {
          "nextScreen": () async {
            await handleLoginNavigation();
          },
        },
      );
      return;
    }
    if (user.location?.address?.isEmpty == true) {
      Get.offAllNamed(
        AppRoutes.locationRequest,
        arguments: {
          "nextScreen": () async {
            await handleLoginNavigation();
          },
        },
      );
      return;
    }
    if (user.dob?.isEmpty == true || user.avatar?.isEmpty == true) {
      Get.offAllNamed(
        AppRoutes.profileUpload,
        arguments: {
          "nextScreen": () async {
            await handleLoginNavigation();
          },
        },
      );
      return;
    }
    if (user.hobbies?.isEmpty == true) {
      Get.offAllNamed(
        AppRoutes.hobby,
        arguments: {
          "nextScreen": () async {
            await handleLoginNavigation();
          },
        },
      );
      return;
    }
    if (user.interestedIn?.isEmpty == true) {
      Get.offAllNamed(
        AppRoutes.relationshipPreference,
        arguments: {
          "nextScreen": () async {
            await handleLoginNavigation();
          },
        },
      );
      return;
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

  Future<void> completeProfile({
    required UserModel userModel,
    required File imageFile,
    VoidCallback? nextScreen,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;

      final response = await _authService.completeProfile(
        userModel: userModel,
        token: token,
        imageFile: imageFile,
      );
      if (response == null) return;

      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      final userController = Get.find<UserController>();
      await userController.getUserDetails();

      if (nextScreen != null) {
        nextScreen();
        return;
      }

      Get.toNamed(AppRoutes.hobby);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> validateToken() async {
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final response = await _authService.validateToken(token: token);
      if (response == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      if (response.statusCode != 200) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      await handleLoginNavigation();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      Get.offAllNamed(AppRoutes.login);
      String? token = await StorageController().getToken();
      if (token == null) {
        return;
      }

      final response = await _authService.logout(token: token);
      if (response == null) return;
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        debugPrint(data["message"].toString());
        return;
      }
      await Get.find<UserController>().clearUserData();
      await Get.find<StorageController>().deleteToken();
      await Get.find<MessageController>().clearChatHistory();
      await Get.find<SubscriptionController>().clearSubscriptionData();
      await Get.find<InviteController>().clearInviteData();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
