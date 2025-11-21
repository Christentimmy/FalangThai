import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  final isloading = false.obs;

  // Animation Controllers
  late AnimationController backgroundAnimationController;
  late AnimationController logoAnimationController;

  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;

  // Form Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable States
  final RxBool isPasswordVisible = false.obs;
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Background animations
    backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    );

    floatAnimation1 = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    floatAnimation2 = Tween<double>(begin: 1.0, end: -1.0).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );

    rotationAnimation =
        Tween<double>(
          begin: 0,
          end: 6.28318530718, // 2π
        ).animate(
          CurvedAnimation(
            parent: backgroundAnimationController,
            curve: Curves.linear,
          ),
        );

    backgroundAnimationController.repeat();

    // Logo animation
    logoAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: logoAnimationController, curve: Curves.easeInOut),
    );

    logoAnimationController.repeat(reverse: true);
  }

  void forgotPassword() {
    _showForgotPasswordDialog();
  }

  void _showForgotPasswordDialog() {
    final text = AppLocalizations.of(Get.context!)!;
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2D2438),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        title: Text(
          text.forgotPassword,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text.forgotPasswordDialogDescription,
              style: GoogleFonts.fredoka(color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: GoogleFonts.fredoka(color: Colors.white),
              controller: emailController,
              decoration: InputDecoration(
                hintText: text.emailAddress,
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              text.cancel,
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ),
          SizedBox(
            height: 45,
            width: 140,
            child: CustomButton(
              ontap: () async {
                if (emailController.text.isEmpty) {
                  CustomSnackbar.showErrorToast(text.emailRequiredError);
                  return;
                }
                await authController.sendOtp(email: emailController.text);
                Get.toNamed(
                  AppRoutes.otpVerification,
                  arguments: {
                    "email": emailController.text,
                    "onVerifiedCallBack": () async {
                      Get.toNamed(
                        AppRoutes.resetPasswordScreen,
                        arguments: {"email": emailController.text},
                      );
                    },
                    "showEditDetails": false,
                  },
                );
              },
              isLoading: authController.isloading,
              child: Text(
                text.sendResetLink,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login({required GlobalKey<FormState> formKey}) async {
    isloading.value = true;
    try {
      if (!formKey.currentState!.validate()) return;
      final authController = Get.find<AuthController>();
      await authController.loginUser(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
      clearForm();
    }
  }

  // Utility Methods
  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    clearForm();
    backgroundAnimationController.dispose();
    logoAnimationController.dispose();

    super.onClose();
  }
}
