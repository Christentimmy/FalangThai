import 'dart:async';
import 'dart:convert';
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
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/register"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(userModel.toJson()),
          )
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
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await client
          .post(
            Uri.parse("$baseUrl/auth/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
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

  Future<http.Response?> changeAuthDetails({
    required String token,
    String? email,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/change-auth-details"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"email": email}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> verifyOtp({
    required String otpCode,
    required String email,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/verify-otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "otp": otpCode}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<http.Response?> sendOtp({required String email}) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/send-otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> completeProfile({
    required UserModel userModel,
    required String token,
    required File imageFile,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/auth/complete-profile");

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..fields['bio'] = userModel.bio!
        ..fields['dob'] = userModel.dob!
        ..files.add(
          await http.MultipartFile.fromPath('avatar', imageFile.path),
        );

      var response = await request.send().timeout(const Duration(seconds: 20));
      return await http.Response.fromStream(response);
    } on SocketException catch (e) {
      CustomSnackbar.showErrorToast("Check internet connection, $e");
      debugPrint("No internet connection");
      return null;
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
