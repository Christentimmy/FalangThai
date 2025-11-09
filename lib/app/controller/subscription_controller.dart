import 'dart:convert';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/subscription_model.dart';
import 'package:falangthai/app/data/services/subscription_service.dart';
import 'package:falangthai/app/utils/url_launcher.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final isloading = false.obs;
  final subscriptionService = SubscriptionService();
  final subscriptionPlans = <SubscriptionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSubscriptionPlans();
  }

  Future<void> getSubscriptionPlans() async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await subscriptionService.getSubscriptionPlans(
        token: token,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      final data = decoded["data"] ?? {};
      if (data == null) return;

      final basic = SubscriptionModel.fromJson(data["BASIC"]);
      final premium = SubscriptionModel.fromJson(data["PREMIUM"]);
      final premiumPlus = SubscriptionModel.fromJson(data["PREMIUM_PLUS"]);
      subscriptionPlans.value = [basic, premium, premiumPlus];
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> createSubscription({required String planId}) async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await subscriptionService.createSubscription(
        planId: planId,
        token: token,
      );
      if (response == null) return;

      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      final data = decoded["data"];
      if (data == null) return;
      final url = data["checkoutUrl"];
      if (url == null) return;

      await urlLauncher(url);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> cancelSubscription() async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await subscriptionService.cancelSubscription(
        token: token,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      await Get.find<UserController>().getUserDetails();
      CustomSnackbar.showSuccessToast(message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> reactivateSubscription() async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await subscriptionService.reactivateUserSubscription(
        token: token,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      await Get.find<UserController>().getUserDetails();
      CustomSnackbar.showSuccessToast(message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
