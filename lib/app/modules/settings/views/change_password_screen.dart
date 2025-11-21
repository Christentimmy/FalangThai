import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/modules/withdraw/widgets/input_field_widget.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final authController = Get.find<AuthController>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                    controller: oldPasswordController,
                    label: l10n.changePasswordCurrentLabel,
                    hint: l10n.changePasswordCurrentHint,
                    icon: Icons.lock,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  InputField(
                    controller: newPasswordController,
                    label: l10n.changePasswordNewLabel,
                    hint: l10n.changePasswordNewHint,
                    icon: Icons.lock,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  InputField(
                    controller: confirmPasswordController,
                    label: l10n.changePasswordConfirmLabel,
                    hint: l10n.changePasswordConfirmHint,
                    icon: Icons.lock,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.changePasswordConfirmEmptyError;
                      }
                      if (value != newPasswordController.text) {
                        return l10n.changePasswordConfirmMismatchError;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.1),
            CustomButton(
              ontap: () async {
                if (!formKey.currentState!.validate()) return;
                await authController.changePassword(
                  oldPassword: oldPasswordController.text,
                  newPassword: newPasswordController.text,
                );
              },
              isLoading: authController.isloading,
              child: Text(
                l10n.changePasswordButton,
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
    final l10n = AppLocalizations.of(Get.context!)!;
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: Colors.white,
      title: Text(
        l10n.changePasswordTitle,
        style: GoogleFonts.fredoka(color: AppColors.primaryColor, fontSize: 20),
      ),
    );
  }
}
