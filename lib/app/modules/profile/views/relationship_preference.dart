import 'package:falangthai/app/modules/profile/controllers/relationship_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RelationshipPreferenceScreen extends StatelessWidget {
  RelationshipPreferenceScreen({super.key});

  final preferenceController = Get.put(RelationshipPreferenceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: SafeArea(
          child: Stack(
            children: [
              _buildAnimatedBackground(),
              _buildContent(),
              _buildHeader(),
            ],
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
          Color(0xFF0F0D15),
          Color(0xFF1F1B2E),
          Color(0xFF2D2438),
          Color(0xFF1A1625),
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: preferenceController.backgroundAnimationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Romantic floating orbs with love-themed colors
              Positioned(
                top: 70 + preferenceController.floatAnimation1.value * 25,
                right: 30,
                child: _buildFloatingOrb(
                  size: 160,
                  colors: [
                    const Color(0xFFEC4899).withValues(alpha: 0.2),
                    const Color(0xFFBE185D).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  rotation: preferenceController.rotationAnimation.value,
                ),
              ),
              Positioned(
                top: 220 + preferenceController.floatAnimation2.value * 30,
                left: -50,
                child: _buildFloatingOrb(
                  size: 200,
                  colors: [
                    const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                    const Color(0xFF7C3AED).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  rotation: -preferenceController.rotationAnimation.value * 0.7,
                ),
              ),
              Positioned(
                bottom: 150 + preferenceController.floatAnimation1.value * 35,
                right: -40,
                child: _buildFloatingOrb(
                  size: 140,
                  colors: [
                    const Color(0xFF06B6D4).withValues(alpha: 0.15),
                    const Color(0xFF0891B2).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  rotation: preferenceController.rotationAnimation.value * 1.2,
                ),
              ),
              Positioned(
                bottom: 320 + preferenceController.floatAnimation2.value * 20,
                left: 30,
                child: _buildFloatingOrb(
                  size: 110,
                  colors: [
                    const Color(0xFF10B981).withValues(alpha: 0.12),
                    const Color(0xFF059669).withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  rotation: preferenceController.rotationAnimation.value * 0.5,
                ),
              ),
              // Floating hearts and relationship symbols
              ...List.generate(8, (index) {
                final icons = [
                  Icons.favorite_rounded,
                  Icons.favorite_border_rounded,
                  Icons.people_rounded,
                  Icons.handshake_rounded,
                  Icons.favorite_rounded,
                  Icons.people_alt_rounded,
                  Icons.favorite_border_rounded,
                  Icons.group_rounded,
                ];
                final colors = [
                  const Color(0xFFEC4899),
                  const Color(0xFF8B5CF6),
                  const Color(0xFF10B981),
                  const Color(0xFF06B6D4),
                  const Color(0xFFF59E0B),
                  const Color(0xFF3B82F6),
                  const Color(0xFFEF4444),
                  const Color(0xFF84CC16),
                ];
                return Positioned(
                  top:
                      100 +
                      (index * 80) +
                      preferenceController.heartbeatAnimation.value * 15,
                  left:
                      50 +
                      (index * 50) +
                      preferenceController.floatAnimation1.value * (5 + index),
                  child: _buildFloatingLoveIcon(
                    icon: icons[index],
                    color: colors[index],
                    size: 18 + (index % 4) * 3,
                    opacity: 0.4 - (index * 0.04),
                  ),
                );
              }),
              // Sparkle effects
              ...List.generate(10, (index) {
                final colors = [
                  const Color(0xFFEC4899),
                  const Color(0xFF8B5CF6),
                  const Color(0xFF06B6D4),
                  const Color(0xFFF59E0B),
                  const Color(0xFF10B981),
                ];
                return Positioned(
                  top:
                      120 +
                      (index * 65) +
                      preferenceController.pulseAnimation.value * 8,
                  right: 70 + (index * 35),
                  child: _buildLoveSparkle(
                    size: 4 + (index % 3) * 2,
                    color: colors[index % colors.length],
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

  Widget _buildFloatingLoveIcon({
    required IconData icon,
    required Color color,
    required double size,
    required double opacity,
  }) {
    return Icon(icon, size: size, color: color.withOpacity(opacity));
  }

  Widget _buildLoveSparkle({
    required double size,
    required Color color,
    required double opacity,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(opacity),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(opacity * 0.5),
            blurRadius: size * 0.8,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
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

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.12),
          _buildProgressIndicator(),
          const SizedBox(height: 30),
          _buildTitle(),
          const SizedBox(height: 8),
          _buildSubtitle(),
          const SizedBox(height: 40),
          // Expanded(child: _buildCurrentStep()),
          Expanded(child: _buildGenderPreferenceSelection()),
          const SizedBox(height: 8),
          _buildContinueButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProgressDot(isActive: true),
        _buildProgressLine(),
        _buildProgressDot(isActive: true),
        _buildProgressLine(),
        _buildProgressDot(isActive: true),
        _buildProgressLine(),
        _buildProgressDot(isActive: true),
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

  Widget _buildTitle() {
    return Text(
      "Who interests you?",
      style: GoogleFonts.fredoka(
        fontSize: 28,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Select preference that apply to help us\nfind your perfect matches",
      style: GoogleFonts.fredoka(
        fontSize: 15,
        color: Colors.white.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildGenderPreferenceSelection() {
    return ListView.builder(
      key: const ValueKey("gender_preferences"),
      itemCount: preferenceController.genderPreferences.length,
      itemBuilder: (context, index) {
        final preference = preferenceController.genderPreferences[index];
        return _buildGenderPreferenceCard(preference: preference, index: index);
      },
    );
  }

  Widget _buildGenderPreferenceCard({
    required PreferenceItem preference,
    required int index,
  }) {
    return Obx(() {
      final isSelected =
          preferenceController.selectedPreference.value == preference.id;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTap: () =>
              preferenceController.toggleGenderPreference(preference.id),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.white.withValues(alpha: 0.15),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(preference.icon, color: Colors.white70, size: 20),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    preference.title,
                    style: GoogleFonts.fredoka(
                      fontSize: 13,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.8),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildContinueButton() {
    return Obx(() {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: preferenceController.canContinue ? 1.0 : 0.5,
        child: CustomButton(
          ontap: () {
            if (!preferenceController.canContinue) return;
            // preferenceController.nextStep();
          },
          isLoading: false.obs,
          borderRadius: BorderRadius.circular(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Continue",
                style: GoogleFonts.fredoka(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: preferenceController.canContinue ? 0 : 0.5,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
