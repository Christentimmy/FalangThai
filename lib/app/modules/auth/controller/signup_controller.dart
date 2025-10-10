import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController with GetTickerProviderStateMixin {
  final isLoading = false.obs;

  // Animation Controllers
  late AnimationController backgroundAnimationController;
  late AnimationController logoAnimationController;

  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;

  // Form Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordVisible = true.obs;
  final RxBool acceptTerms = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Background animations
    backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 20),
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
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
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
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: logoAnimationController, curve: Curves.easeInOut),
    );

    logoAnimationController.repeat(reverse: true);
  }

  String? validateName(String? value) {
    if (value == null) return null;
    if (value.isEmpty) {
      return '';
    } else if (value.length < 2) {
      return "";
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value == null) return null;
    if (value.isEmpty) {
      return '';
    } else {
      return null;
    }
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    acceptTerms.value = false;
  }

  Future<void> signUp() async {
    if (!acceptTerms.value) {
      CustomSnackbar.showErrorToast("Accept Terms and conditions");
      return;
    }
    isLoading.value = true;
    final authController = Get.find<AuthController>();
    final userModel = UserModel(
      fullName: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    await authController.signUpUSer(userModel: userModel);
    isLoading.value = false;
    // clearForm();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    backgroundAnimationController.dispose();
    logoAnimationController.dispose();
    super.onClose();
  }
}
