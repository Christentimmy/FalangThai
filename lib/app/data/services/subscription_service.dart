import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:falangthai/app/utils/base_url.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubscriptionService {
  
  Future<http.Response?> createSubscription({
    required String planId,
    required String token,
  }) {
    return safeRequest(() {
      return http.post(
        Uri.parse("$baseUrl/subscription/create"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"planId": planId}),
      );
    }, context: 'createSubscription');
  }

  Future<http.Response?> getSubscriptionPlans({required String token}) {
    return safeRequest(() {
      return http.get(
        Uri.parse("$baseUrl/subscription/plans"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'getSubscriptionPlans');
  }

  Future<http.Response?> cancelSubscription({required String token}) {
    return safeRequest(() {
      return http.post(
        Uri.parse("$baseUrl/subscription/cancel"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'cancelSubscription');
  }

  Future<http.Response?> reactivateUserSubscription({required String token}) {
    return safeRequest(() {
      return http.post(
        Uri.parse("$baseUrl/subscription/reactivate"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'reactivateUserSubscription');
  }

  Future<http.Response?> safeRequest(
    Future<http.Response> Function() request, {
    String? context,
  }) async {
    try {
      return await request().timeout(const Duration(seconds: 15));
    } on SocketException {
      CustomSnackbar.showErrorToast("No internet connection");
    } on TimeoutException {
      CustomSnackbar.showErrorToast("Request timeout, please try again");
    } catch (e) {
      debugPrint("Error in ${context ?? 'request'}: $e");
    }
    return null;
  }
}
