import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
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



}
