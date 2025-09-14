import 'dart:math' as math;
import 'package:falangthai/app/modules/auth/controller/signup_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/utils/validator.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: SafeArea(
          child: Stack(
            children: [_buildAnimatedShapes(), _buildContent(), _buildHeader()],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A1625),
          Color(0xFF2D2438),
          Color(0xFF1F1B2E),
          Color(0xFF0F0D15),
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      ),
    );
  }

  Widget _buildAnimatedShapes() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: signupController.backgroundAnimationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Floating circles
              Positioned(
                top: 100 + signupController.floatAnimation1.value * 20,
                right: 50,
                child: _buildFloatingShape(
                  size: 120,
                  color: AppColors.primaryColor.withOpacity(0.1),
                  rotation: signupController.rotationAnimation.value,
                ),
              ),
              Positioned(
                top: 300 + signupController.floatAnimation2.value * 15,
                left: -30,
                child: _buildFloatingShape(
                  size: 200,
                  color: Colors.purple.withOpacity(0.08),
                  rotation: -signupController.rotationAnimation.value * 0.7,
                ),
              ),
              Positioned(
                bottom: 150 + signupController.floatAnimation1.value * 25,
                right: -50,
                child: _buildFloatingShape(
                  size: 150,
                  color: Colors.cyan.withOpacity(0.06),
                  rotation: signupController.rotationAnimation.value * 1.2,
                ),
              ),
              // Gradient orbs
              Positioned(
                top: 200,
                left: 30 + signupController.floatAnimation2.value * 10,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFloatingShape({
    required double size,
    required Color color,
    required double rotation,
  }) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, Colors.transparent],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 20,
      left: 20,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: signupController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Falang",
                    style: GoogleFonts.fredoka(
                      fontSize: 30,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Thai",
                    style: GoogleFonts.fredoka(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildTitle(),
              _buildSubtitle(),
              const SizedBox(height: 32),
              CustomTextField(
                controller: signupController.nameController,
                bgColor: Colors.white.withOpacity(0.05),
                prefixIcon: Icons.person,
                prefixIconColor: AppColors.primaryColor,
                hintText: "Full Name",
                hintStyle: GoogleFonts.fredoka(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                validator: signupController.validateName,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: signupController.emailController,
                bgColor: Colors.white.withValues(alpha: 0.05),
                prefixIcon: Icons.email,
                prefixIconColor: AppColors.primaryColor,
                hintText: "Email",
                hintStyle: GoogleFonts.fredoka(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                validator: validateEmail,
              ),
              // _buildEmailField(),
              const SizedBox(height: 20),
              Obx(() {
                return CustomTextField(
                  controller: signupController.passwordController,
                  bgColor: Colors.white.withValues(alpha: 0.05),
                  prefixIcon: Icons.lock,
                  prefixIconColor: AppColors.primaryColor,
                  hintText: "Password",
                  hintStyle: GoogleFonts.fredoka(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  isObscure: signupController.isPasswordVisible.value,
                  suffixIcon: signupController.isPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  suffixIconcolor: AppColors.primaryColor,
                  validator: signupController.validatePassword,
                  onSuffixTap: () {
                    signupController.isPasswordVisible.value =
                        !signupController.isPasswordVisible.value;
                  },
                );
              }),
              const SizedBox(height: 20),
              _buildTermsCheckbox(),
              const SizedBox(height: 32),
              CustomButton(
                ontap: () {},
                isLoading: false.obs,
                borderRadius: BorderRadius.circular(22),
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildSocialLogin(),
              const SizedBox(height: 20),
              _buildLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return AnimatedBuilder(
      animation: signupController.logoAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + signupController.pulseAnimation.value * 0.1,
          child: Transform.rotate(
            angle: math.pi / 0.53,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/logo.png",
                width: 80,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      "Create Account",
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Join our community and start connecting",
      style: GoogleFonts.fredoka(
        fontSize: 16,
        color: Colors.white.withOpacity(0.7),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Obx(
      () => Row(
        children: [
          GestureDetector(
            onTap: signupController.acceptTerms.toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: signupController.acceptTerms.value
                      ? AppColors.primaryColor
                      : Colors.white.withValues(alpha: 0.5),
                  width: 2,
                ),
                color: signupController.acceptTerms.value
                    ? AppColors.primaryColor
                    : Colors.transparent,
              ),
              child: signupController.acceptTerms.value
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.fredoka(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  const TextSpan(text: "I agree to the "),
                  TextSpan(
                    text: "Terms of Service",
                    style: GoogleFonts.fredoka(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: GoogleFonts.fredoka(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(height: 1, color: Colors.white.withOpacity(0.3)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Or continue with",
                style: GoogleFonts.fredoka(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: Container(height: 1, color: Colors.white.withOpacity(0.3)),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildSocialButton(
                icon: FontAwesomeIcons.google,
                label: "Google",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSocialButton(
                icon: FontAwesomeIcons.facebook,
                label: "Facebook",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
          color: Colors.white.withValues(alpha: 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.fredoka(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.fredoka(
            fontSize: 16,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
          children: [
            const TextSpan(text: "Already have an account? "),
            TextSpan(
              text: "Sign In",
              style: GoogleFonts.fredoka(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
