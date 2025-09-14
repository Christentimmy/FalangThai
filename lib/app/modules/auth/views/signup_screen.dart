import 'dart:ui';
import 'dart:math' as math;
import 'package:falangthai/app/modules/auth/controller/signup_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _buildLogo(),
            SizedBox(height: Get.height * 0.1),
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
            // _buildSignupCard(),
            _buildTitle(),
            // SizedBox(height: Get.height * 0.02),
            _buildSubtitle(),
            const SizedBox(height: 32),
            // _buildNameField(),
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
            ),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildConfirmPasswordField(),
            const SizedBox(height: 12),
            _buildTermsCheckbox(),
            const SizedBox(height: 32),
            _buildSignupButton(),
            const SizedBox(height: 30),
            _buildSocialLogin(),
            const SizedBox(height: 20),
            _buildLoginLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
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

  Widget _buildSignupCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 8),
              _buildSubtitle(),
              const SizedBox(height: 32),
              _buildNameField(),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildConfirmPasswordField(),
              const SizedBox(height: 12),
              _buildTermsCheckbox(),
              const SizedBox(height: 32),
              _buildSignupButton(),
            ],
          ),
        ),
      ),
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

  Widget _buildNameField() {
    return Obx(
      () => _buildTextField(
        controller: signupController.nameController,
        hintText: "Full Name",
        prefixIcon: Icons.person_outline,
        errorText: signupController.nameError.value.isEmpty
            ? null
            : signupController.nameError.value,
        onChanged: signupController.validateName,
      ),
    );
  }

  Widget _buildEmailField() {
    return Obx(
      () => _buildTextField(
        controller: signupController.emailController,
        hintText: "Email Address",
        prefixIcon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
        errorText: signupController.emailError.value.isEmpty
            ? null
            : signupController.emailError.value,
        onChanged: signupController.validateEmail,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => _buildTextField(
        controller: signupController.passwordController,
        hintText: "Password",
        prefixIcon: Icons.lock_outline,
        isPassword: true,
        isPasswordVisible: signupController.isPasswordVisible.value,
        onTogglePassword: signupController.togglePasswordVisibility,
        errorText: signupController.passwordError.value.isEmpty
            ? null
            : signupController.passwordError.value,
        onChanged: signupController.validatePassword,
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Obx(
      () => _buildTextField(
        controller: signupController.confirmPasswordController,
        hintText: "Confirm Password",
        prefixIcon: Icons.lock_outline,
        isPassword: true,
        isPasswordVisible: signupController.isConfirmPasswordVisible.value,
        onTogglePassword: signupController.toggleConfirmPasswordVisibility,
        errorText: signupController.confirmPasswordError.value.isEmpty
            ? null
            : signupController.confirmPasswordError.value,
        onChanged: signupController.validateConfirmPassword,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    String? errorText,
    Function(String)? onChanged,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: errorText != null
              ? Colors.red.withOpacity(0.5)
              : Colors.white.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          if (errorText != null)
            BoxShadow(
              color: Colors.red.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomTextField(),
          TextFormField(
            controller: controller,
            obscureText: isPassword && !isPasswordVisible,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: GoogleFonts.fredoka(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.fredoka(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: AppColors.primaryColor.withOpacity(0.8),
                size: 22,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: onTogglePassword,
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.white.withOpacity(0.6),
                        size: 22,
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
              fillColor: Colors.white.withOpacity(0.05),
              filled: true,
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                errorText,
                style: GoogleFonts.fredoka(
                  color: Colors.red.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Obx(
      () => Row(
        children: [
          GestureDetector(
            onTap: signupController.toggleTermsAcceptance,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: signupController.acceptTerms.value
                      ? AppColors.primaryColor
                      : Colors.white.withOpacity(0.5),
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

  Widget _buildSignupButton() {
    return Obx(
      () => CustomButton(
        ontap:
            signupController.isFormValid && signupController.acceptTerms.value
            ? signupController.signup
            : () {},
        isLoading: signupController.isLoading,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors:
                  signupController.isFormValid &&
                      signupController.acceptTerms.value
                  ? [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.8),
                    ]
                  : [Colors.grey.shade600, Colors.grey.shade700],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create Account",
                style: GoogleFonts.fredoka(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
            ],
          ),
        ),
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
                icon: Icons.g_mobiledata,
                label: "Google",
                onTap: signupController.signupWithGoogle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSocialButton(
                icon: Icons.facebook,
                label: "Facebook",
                onTap: signupController.signupWithFacebook,
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
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          color: Colors.white.withOpacity(0.05),
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
