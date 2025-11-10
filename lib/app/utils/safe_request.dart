import 'dart:async';
import 'dart:io';

import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
