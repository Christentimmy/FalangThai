import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2D2438),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        title: Text(
          'Reset Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your email address and we\'ll send you a link to reset your password.',
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Email Address',
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
              'Cancel',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Password Reset',
                'Reset link sent to your email!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.9),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9EE6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Send Reset Link',
              style: TextStyle(color: Colors.white),
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
