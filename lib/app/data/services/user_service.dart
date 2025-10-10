import 'dart:async';
// import 'dart:convert';
import 'dart:io';
import 'package:falangthai/app/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';

class UserService {
  http.Client client = http.Client();

  Future<http.Response?> getUserDetails({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-user-details"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
