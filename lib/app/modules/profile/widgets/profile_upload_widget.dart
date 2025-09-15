import 'package:falangthai/app/modules/profile/controllers/profile_upload_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUploadWidget {
  BoxDecoration buildBackgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0F0D15),
          Color(0xFF1F1B2E),
          Color(0xFF2D2438),
          Color(0xFF1A1625),
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      ),
    );
  }

  Widget buildAnimatedBackground() {
    final profileController = Get.find<ProfileUploadController>();
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: profileController.backgroundAnimationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Main floating orbs
              Positioned(
                top: 60 + profileController.floatAnimation1.value * 20,
                right: 20,
                child: _buildFloatingOrb(
                  size: 140,
                  colors: [
                    AppColors.primaryColor.withValues(alpha: 0.15),
                    Colors.purple.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  rotation: profileController.rotationAnimation.value,
                ),
              ),
              Positioned(
                top: 180 + profileController.floatAnimation2.value * 25,
                left: -30,
                child: _buildFloatingOrb(
                  size: 160,
                  colors: [
                    Colors.cyan.withValues(alpha: 0.12),
                    Colors.blue.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  rotation: -profileController.rotationAnimation.value * 0.7,
                ),
              ),
              Positioned(
                bottom: 100 + profileController.floatAnimation1.value * 30,
                right: -50,
                child: _buildFloatingOrb(
                  size: 120,
                  colors: [
                    Colors.pink.withValues(alpha: 0.12),
                    Colors.purple.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  rotation: profileController.rotationAnimation.value * 1.2,
                ),
              ),
              Positioned(
                bottom: 250 + profileController.floatAnimation2.value * 22,
                left: 10,
                child: _buildFloatingOrb(
                  size: 100,
                  colors: [
                    Colors.teal.withValues(alpha: 0.1),
                    Colors.green.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                  rotation: profileController.rotationAnimation.value * 0.5,
                ),
              ),
              // Smaller accent orbs
              ...List.generate(6, (index) {
                return Positioned(
                  top:
                      120 +
                      (index * 80) +
                      profileController.floatAnimation1.value *
                          (10 + index * 2),
                  left:
                      40 +
                      (index * 60) +
                      profileController.floatAnimation2.value * (8 + index),
                  child: _buildAccentOrb(
                    size: 15 + (index * 3).toDouble(),
                    opacity: 0.4 - (index * 0.05),
                  ),
                );
              }),
              // Sparkle effects
              ...List.generate(8, (index) {
                return Positioned(
                  top:
                      100 +
                      (index * 70) +
                      profileController.pulseAnimation.value * 5,
                  right: 80 + (index * 40),
                  child: _buildSparkle(
                    size: 4 + (index % 3) * 2,
                    opacity: 0.6 - (index * 0.05),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFloatingOrb({
    required double size,
    required List<Color> colors,
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
            colors: colors,
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildAccentOrb({required double size, required double opacity}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor.withOpacity(opacity),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(opacity * 0.5),
            blurRadius: size * 0.3,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildSparkle({required double size, required double opacity}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(opacity * 0.5),
            blurRadius: size,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
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
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  "Skip",
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProgressDot(isActive: true),
        _buildProgressLine(),
        _buildProgressDot(isActive: true),
        _buildProgressLine(),
        _buildProgressDot(isActive: false),
        _buildProgressLine(),
        _buildProgressDot(isActive: false),
      ],
    );
  }

  Widget _buildProgressDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppColors.primaryColor
            : Colors.white.withValues(alpha: 0.3),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildProgressLine() {
    return Container(
      width: 24,
      height: 2,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
