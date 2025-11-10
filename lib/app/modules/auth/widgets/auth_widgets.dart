import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/utils/validator.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthWidgets {
  BoxDecoration buildBackgroundDecoration() {
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

  Widget buildFloatingShape({
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

  Widget buildTitle({required String title}) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildSubtitle({required String subtitle}) {
    return Text(
      subtitle,
      style: GoogleFonts.fredoka(
        fontSize: 16,
        color: Colors.white.withOpacity(0.7),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildSocialButton({
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
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
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

  Widget buildLoginLink() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.login),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.fredoka(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.7),
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

  Widget buildSocialLogin() {
    final authController = Get.find<AuthController>();
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
              child: Obx(() {
                return buildSocialButton(
                  icon: FontAwesomeIcons.google,
                  label: authController.isloading.value
                      ? "Loading..."
                      : "Google",
                  onTap: () async {
                    await authController.googleAuthSignIn();
                  },
                );
              }),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: buildSocialButton(
                icon: FontAwesomeIcons.facebook,
                label: "Facebook",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSignupLink() {
    return GestureDetector(
      onTap: () => Get.toNamed('/signup'),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.fredoka(
            fontSize: 16,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: "Sign Up",
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

enum ContactType { email, phone }

class ContactUpdateBottomSheet extends StatefulWidget {
  final ContactType type;
  final String initialValue;
  final Function(String) onSave;

  const ContactUpdateBottomSheet({
    super.key,
    required this.type,
    required this.initialValue,
    required this.onSave,
  });

  static Future<void> show({
    required BuildContext context,
    required ContactType type,
    required String initialValue,
    required Function(String) onSave,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ContactUpdateBottomSheet(
        type: type,
        initialValue: initialValue,
        onSave: onSave,
      ),
    );
  }

  @override
  State<ContactUpdateBottomSheet> createState() =>
      _ContactUpdateBottomSheetState();
}

class _ContactUpdateBottomSheetState extends State<ContactUpdateBottomSheet> {
  late TextEditingController _controller;
  final _authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final title = 'Update Email';
    final hint = 'Enter your email';
    final keyboardType = TextInputType.emailAddress;
    final inputFormatters = null;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0F0D15),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          border: Border(
            top: BorderSide(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Email:',
                    style: GoogleFonts.fredoka(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.initialValue,
                    style: GoogleFonts.fredoka(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'New Email:',
                    style: GoogleFonts.fredoka(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: CustomTextField(
                      hintText: hint,
                      controller: _controller,
                      keyboardType: keyboardType,
                      inputFormatters: inputFormatters,
                      validator: validateEmail,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    ontap: () {
                      if (!_formKey.currentState!.validate()) return;
                      widget.onSave(_controller.text);
                    },
                    isLoading: _authController.isloading,
                    child: Text(
                      'Save Changes',
                      style: GoogleFonts.fredoka(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
