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

  //potential matches variables
  RxList<UserModel> potentialMatchesList = <UserModel>[].obs;
  RxInt currentPage = 1.obs;
  RxBool hasNextPage = false.obs;

  //users who likes me variables
  RxList<UserModel> usersWhoLikesMeList = <UserModel>[].obs;

  //matches variables
  RxList<UserModel> matchesList = <UserModel>[].obs;

  Future<void> getUserDetails() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserDetails(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) return;

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

  Future<void> updateHobbies({
    required List<String> hobbies,
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
      final response = await _userService.updateHobbies(
        token: token,
        hobbies: hobbies,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      if (nextScreen != null) {
        await getUserDetails();
        nextScreen();
        return;
      }
      await getUserDetails();
      Get.toNamed(AppRoutes.relationshipPreference);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateInterestIn({
    VoidCallback? nextScreen,
    required String interestedIn,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return;
      }
      final response = await _userService.updateInterestedIn(
        token: token,
        interestedIn: interestedIn,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      await getUserDetails();

      if (nextScreen != null) {
        nextScreen();
        return;
      }

      Get.offAllNamed(AppRoutes.bottomNavigation);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> saveUserOneSignalId({required String id}) async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return;
      }
      final response = await _userService.saveUserOneSignalId(
        token: token,
        id: id,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getPotentialMatches({
    bool? loadMore = false,
    bool showLoader = true,
  }) async {
    isloading.value = showLoader;

    try {
      if (loadMore == true && hasNextPage.value) {
        currentPage.value++;
      } else {
        currentPage.value = 1;
        potentialMatchesList.clear();
      }

      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getPotentialMatches(
        token: token,
        page: currentPage.value,
      );

      if (response == null) return;

      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        debugPrint(decoded["message"].toString());
        return;
      }

      List matches = decoded["data"] ?? [];
      hasNextPage.value = decoded["hasNextPage"] ?? false;
      if (matches.isEmpty) return;

      List<UserModel> mapped = matches
          .map((e) => UserModel.fromJson(e))
          .toList();
      if (loadMore == true && hasNextPage.value == true) {
        potentialMatchesList.addAll(mapped);
      } else {
        potentialMatchesList.value = mapped;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<UserModel?> getUserWithId({required String userId}) async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return null;
      }
      final response = await _userService.getUserWithId(
        token: token,
        userId: userId,
      );
      if (response == null) return null;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        CustomSnackbar.showErrorToast(decoded["message"]);
        return null;
      }
      return UserModel.fromJson(decoded["data"]);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> swipe({required String userId, required SwipeType type}) async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.swipeLike(
        token: token,
        targetUserId: userId,
        type: type.name.toLowerCase(),
      );

      if (response == null) return;
      final decoded = json.decode(response.body);

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(decoded["message"]);
        return;
      }
      removeUserFromPotentialList(userId);

      final match = decoded["match"];
      if (match == null) return;

      String targetUserId = match["targetUserId"] ?? "";
      if (targetUserId.isEmpty) return;

      Get.toNamed(AppRoutes.match, arguments: {"targetUserId": targetUserId});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeUserFromPotentialList(String userId) {
    potentialMatchesList.removeWhere((element) => element.id == userId);
  }

  Future<void> getUserWhoLikesMe() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserWhoLikesMe(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        debugPrint(decoded["message"].toString());
        return;
      }
      List matches = decoded["data"] ?? [];
      if (matches.isEmpty) return;
      List<UserModel> mapped = matches
          .map((e) => UserModel.fromJson(e))
          .toList();
      usersWhoLikesMeList.value = mapped;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getMatches() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getMatches(token: token);

      if (response == null) return;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        debugPrint(decoded["message"].toString());
        return;
      }
      List matches = decoded["data"] ?? [];
      matchesList.clear();
      if (matches.isEmpty) return;
      List<UserModel> mapped = matches
          .map((e) => UserModel.fromJson(e))
          .toList();
      matchesList.value = mapped;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  clearUserData() {
    userModel.value = null;
    isloading.value = false;
    potentialMatchesList.clear();
    currentPage.value = 1;
    hasNextPage.value = false;
    usersWhoLikesMeList.clear();
  }
}

enum SwipeType { pass, superlike, like }
