import 'dart:convert';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/services/wallet_service.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  final walletService = WalletService();
  final isloading = false.obs;

  Future<void> updatePayment({
    required String paymentMethod,
    required dynamic paymentDetails,
  }) async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await walletService.updatePayment(
        token: token,
        paymentMethod: paymentMethod,
        paymentDetails: paymentDetails,
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

      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}

class PaymentMethod {
  final String bankTransfer = 'bank_transfer';
  final String paypal = 'paypal';
  final String stripe = 'stripe';
}
