import 'package:flutter/material.dart';
import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/modules/withdraw/widgets/input_field_widget.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  ResetPasswordScreen({super.key, required this.email});

  final authController = Get.find<AuthController>();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: Get.height * 0.05),
            Form(
              key: formKey,
              child: Column(
                children: [
                  InputField(
                    controller: passwordController,
                    label: "New Password",
                    hint: "Enter your new password",
                    icon: Icons.lock,
                  ),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.1),
            CustomButton(
              ontap: () async {
                if (!formKey.currentState!.validate()) return;
                await authController.resetPassword(
                  email: email,
                  password: passwordController.text,
                );
              },
              isLoading: authController.isloading,
              child: Text(
                "Reset Password",
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: Colors.white,
      title: Text(
        "Change Password",
        style: GoogleFonts.fredoka(color: AppColors.primaryColor, fontSize: 20),
      ),
    );
  }
}
