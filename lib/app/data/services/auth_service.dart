import 'dart:async';
import 'dart:io';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/utils/base_url.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  http.Client client = http.Client();

  Future<http.Response?> signUpUser({required UserModel userModel}) async {
    print(userModel.toJson().toString());
    try {
      final response = await client
          .post(Uri.parse("$baseUrl/auth/register"), body: userModel.toJson())
          .timeout(const Duration(seconds: 10));
      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorToast("Check internet connection");
      debugPrint("SocketException: $e");
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably Bad network, try again",
      );
      debugPrint("Request Time out");
    } catch (e) {
      debugPrint("Error From Auth Servie: ${e.toString()}");
    }
    return null;
  }

  Future<http.Response?> loginUser({
    required String identifier,
    required String password,
  }) async {
    try {
      http.Response response = await client
          .post(
            Uri.parse("$baseUrl/auth/login"),
            body: {"identifier": identifier, "password": password},
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on SocketException catch (_) {
      CustomSnackbar.showErrorToast("Host connection unstable");
      debugPrint("No internet connection");
      return null;
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
  }
}
