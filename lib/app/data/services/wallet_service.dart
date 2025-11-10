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
}
