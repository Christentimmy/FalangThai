import 'dart:math' as math;
import 'package:falangthai/app/modules/auth/controller/login_controller.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/utils/validator.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginController = Get.put(LoginController());
  final authWidgets = AuthWidgets();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: authWidgets.buildBackgroundDecoration(),
        child: SafeArea(
          child: Stack(
            children: [_buildAnimatedShapes(), _buildContent(), _buildHeader()],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedShapes() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: loginController.backgroundAnimationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Floating circles
              Positioned(
                top: 120 + loginController.floatAnimation1.value * 25,
                right: 40,
                child: _buildFloatingShape(
                  size: 140,
                  color: AppColors.primaryColor.withOpacity(0.12),
                  rotation: loginController.rotationAnimation.value,
                ),
              ),
              Positioned(
                top: 280 + loginController.floatAnimation2.value * 20,
                left: -40,
                child: _buildFloatingShape(
                  size: 180,
                  color: Colors.purple.withOpacity(0.1),
                  rotation: -loginController.rotationAnimation.value * 0.6,
                ),
              ),
              Positioned(
                bottom: 180 + loginController.floatAnimation1.value * 30,
                right: -60,
                child: _buildFloatingShape(
                  size: 160,
                  color: Colors.cyan.withOpacity(0.08),
                  rotation: loginController.rotationAnimation.value * 1.3,
                ),
              ),
              // Additional floating elements for login
              Positioned(
                top: 160,
                left: 20 + loginController.floatAnimation2.value * 15,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.25),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: 50 + loginController.floatAnimation1.value * 12,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.purple.withOpacity(0.2),
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
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.08),
              _buildLogo(),
              const SizedBox(height: 40),
              _buildBrandName(),
              const SizedBox(height: 8),
              authWidgets.buildTitle(title: "Welcome Back"),
              const SizedBox(height: 6),
              authWidgets.buildSubtitle(
                subtitle: "Sign in to continue your journey",
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: loginController.emailController,
                bgColor: Colors.white.withValues(alpha: 0.05),
                prefixIcon: Icons.email,
                prefixIconColor: AppColors.primaryColor,
                hintText: "Email Address",
                hintStyle: GoogleFonts.fredoka(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                validator: validateEmail,
              ),
              const SizedBox(height: 20),
              Obx(() {
                return CustomTextField(
                  controller: loginController.passwordController,
                  bgColor: Colors.white.withValues(alpha: 0.05),
                  prefixIcon: Icons.lock,
                  prefixIconColor: AppColors.primaryColor,
                  hintText: "Password",
                  hintStyle: GoogleFonts.fredoka(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  isObscure: loginController.isPasswordVisible.value,
                  suffixIcon: loginController.isPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  suffixIconcolor: AppColors.primaryColor,
                  onSuffixTap: () {
                    loginController.isPasswordVisible.value =
                        !loginController.isPasswordVisible.value;
                  },
                );
              }),
              const SizedBox(height: 16),
              _buildForgotPassword(),
              const SizedBox(height: 32),
              CustomButton(
                ontap: () async {
                  await loginController.login(formKey: formKey);
                },
                isLoading: loginController.isloading,
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In",
                      style: GoogleFonts.fredoka(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // _buildSocialLogin(),
              authWidgets.buildSocialLogin(),
              const SizedBox(height: 24),
              // _buildSignupLink(),
              authWidgets.buildSignupLink(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: loginController.logoAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + loginController.pulseAnimation.value * 0.08,
          child: Transform.rotate(
            angle: math.pi / 0.53,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryColor.withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.4),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/logo.png",
                width: 60,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Falang",
          style: GoogleFonts.fredoka(
            fontSize: 28,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "Thai",
          style: GoogleFonts.fredoka(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: loginController.forgotPassword,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Text(
            "Forgot Password?",
            style: GoogleFonts.fredoka(
              fontSize: 14,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
