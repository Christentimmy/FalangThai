import 'dart:convert';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/commission_model.dart';
import 'package:falangthai/app/data/models/withdraw_model.dart';
import 'package:falangthai/app/data/services/wallet_service.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  final walletService = WalletService();
  final isloading = false.obs;
  final recentWithdraw = [].obs;

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

  Future<void> getRecentWithdraw() async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await walletService.getRecentWithdrawal(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      print(decoded);
      final rawCommissions = decoded["data"]["commissions"] ?? [];
      final commissions = rawCommissions
          .map((e) => CommissionModel.fromJson(e))
          .toList();
      final rawWithdrawals = decoded["data"]["withdrawals"] ?? [];
      final withdrawals = rawWithdrawals
          .map((e) => WithdrawModel.fromJson(e))
          .toList();
      List<dynamic> allTransactions = [...commissions, ...withdrawals];
      allTransactions.sort((a, b) {
        DateTime? dateA = a is CommissionModel
            ? a.date
            : (a as WithdrawModel).date;
        DateTime? dateB = b is CommissionModel
            ? b.date
            : (b as WithdrawModel).date;
        return dateB!.compareTo(dateA!);
      });

      recentWithdraw.value = allTransactions;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getWithdrawals() async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await walletService.getWithdrawals(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final rawWithdrawals = decoded["data"] ?? [];
      final withdrawals = rawWithdrawals
          .map((e) => WithdrawModel.fromJson(e))
          .toList();
      recentWithdraw.value = withdrawals;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getCommissions() async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await walletService.getCommissions(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final rawCommissions = decoded["data"] ?? [];
      final commissions = rawCommissions
          .map((e) => CommissionModel.fromJson(e))
          .toList();
      recentWithdraw.value = commissions;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> requestWithdrawal({
    required num amount,
    required String paymentMethod,
  }) async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) return;

      final response = await walletService.requestWithdrawal(
        token: token,
        amount: amount,
        paymentMethod: paymentMethod,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final controller = Get.find<UserController>();
      await controller.getUserDetails();
      CustomSnackbar.showSuccessToast(message);
      Get.back();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}

class PaymentMethod {
  static final String bankTransfer = 'bank_transfer';
  static final String paypal = 'paypal';
  static final String stripe = 'stripe';
}
