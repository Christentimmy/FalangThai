import 'package:cherry_toast/cherry_toast.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackbar {
  static void showErrorToast(String message) {
    CherryToast.error(
      title: Text(
        "Error",
        style: GoogleFonts.fredoka(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
        style: GoogleFonts.fredoka(color: Colors.black),
      ),
      // backgroundColor: const Color.fromARGB(216, 244, 67, 54),
      animationDuration: const Duration(milliseconds: 300),
      autoDismiss: true,
      borderRadius: 14,
      shadowColor: Colors.transparent,

      // iconWidget: Padding(
      //   padding: const EdgeInsets.only(left: 8.0),
      //   child: CircleAvatar(
      //     backgroundColor: Colors.white,
      //     child: Icon(Icons.error, size: 23, color: Colors.red),
      //   ),
      // ),
      enableIconAnimation: true,
    ).show(Get.context!);
  }

  static void showSuccessToast(String message) {
    CherryToast.success(
      title: Text(
        "Success",
        style: GoogleFonts.fredoka(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
        style: GoogleFonts.fredoka(color: Colors.white),
      ),
      backgroundColor: AppColors.primaryColor,
      animationDuration: const Duration(milliseconds: 300),
      autoDismiss: true,
      borderRadius: 14,

      iconWidget: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 177, 118, 162).withValues(alpha: 0.2),
          child: Icon(Icons.check_circle, size: 23, color: Colors.white),
        ),
      ),
      enableIconAnimation: true,
    ).show(Get.context!);
  }
}
