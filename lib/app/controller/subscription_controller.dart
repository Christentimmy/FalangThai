import 'dart:convert';

import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/data/services/subscription_service.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final isloading = false.obs;
  final subscriptionService = SubscriptionService();

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
    } catch (e) {
      debugPrint(e.toString());
    }
    isloading.value = false;
  }
}
