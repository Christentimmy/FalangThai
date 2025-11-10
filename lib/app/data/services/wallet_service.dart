import 'dart:convert';

import 'package:falangthai/app/utils/base_url.dart';
import 'package:falangthai/app/utils/safe_request.dart';
import 'package:http/http.dart' as http;

class WalletService {

  Future<http.Response?> updatePayment({
    required String token,
    required String paymentMethod,
    required dynamic paymentDetails,
  }) async {
    return safeRequest(() {
      return http.put(
        Uri.parse("$baseUrl/wallet/payment-info"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "paymentMethod": paymentMethod,
          "paymentDetails": paymentDetails,
        }),
      );
    }, context: 'updatePayment');
  }

  Future<http.Response?> getRecentWithdrawal({
    required String token,
  }) async {
    return safeRequest(() {
      return http.get(
        Uri.parse("$baseUrl/wallet/history"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'getRecentWithdrawal');
  }

  Future<http.Response?> getWithdrawals({
    required String token,
  }) async {
    return safeRequest(() {
      return http.get(
        Uri.parse("$baseUrl/wallet/withdrawals"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'getWithdrawals');
  }

  Future<http.Response?> getCommissions({
    required String token,
  }) async {
    return safeRequest(() {
      return http.get(
        Uri.parse("$baseUrl/wallet/commissions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'getCommissions');
  }

  Future<http.Response?> requestWithdrawal({
    required String token,
    required num amount,
    required String paymentMethod,
  }) async {
    return safeRequest(() {
      return http.post(
        Uri.parse("$baseUrl/wallet/withdraw"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "amount": amount,
          "paymentMethod": paymentMethod,
        }),
      );
    }, context: 'requestWithdrawal');
  }

}
