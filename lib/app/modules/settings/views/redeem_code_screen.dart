import 'package:falangthai/app/controller/invite_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RedeemCodeScreen extends StatelessWidget {
  RedeemCodeScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final inviteController = Get.find<InviteController>();
  final redeemCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1625),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.primaryColor,
        title: Text(
          'Redeem Code',
          style: GoogleFonts.fredoka(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Were you invited by a friend? Use their redeem code to get Falang points! and 20% money reward after you subscribe.',
                style: GoogleFonts.fredoka(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: CustomTextField(
                  hintText: 'Enter redeem code',
                  textStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: redeemCodeController,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Please enter a valid redeem code';
                    }
                    if (value.isEmpty) {
                      return 'Please enter a redeem code';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                ontap: () async {
                  if (!formKey.currentState!.validate()) return;
                  final code = redeemCodeController.text.trim();
                  await inviteController.redeemInvite(inviteCode: code);
                },
                isLoading: inviteController.isloading,
                child: Text(
                  'Redeem',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.bottomNavigation);
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
