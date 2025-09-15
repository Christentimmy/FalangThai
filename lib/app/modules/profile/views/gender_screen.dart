import 'package:falangthai/app/modules/profile/controllers/gender_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderScreen extends StatelessWidget {
  GenderScreen({super.key});

  final genderController = Get.put(GenderController());

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
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
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

  Widget _buildAnimatedShapes() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: genderController.backgroundAnimationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Floating gender-themed shapes
              Positioned(
                top: 80 + genderController.floatAnimation1.value * 15,
                right: 30,
                child: _buildFloatingShape(
                  size: 100,
                  colors: [Colors.pink.withValues(alpha: 0.15), Colors.transparent],
                  rotation: genderController.rotationAnimation.value,
                ),
              ),
              Positioned(
                top: 200 + genderController.floatAnimation2.value * 20,
                left: -20,
                child: _buildFloatingShape(
                  size: 130,
                  colors: [Colors.blue.withValues(alpha: 0.12), Colors.transparent],
                  rotation: -genderController.rotationAnimation.value * 0.8,
                ),
              ),
              Positioned(
                bottom: 120 + genderController.floatAnimation1.value * 25,
                right: -40,
                child: _buildFloatingShape(
                  size: 110,
                  colors: [Colors.purple.withValues(alpha: 0.1), Colors.transparent],
                  rotation: genderController.rotationAnimation.value * 1.5,
                ),
              ),
              Positioned(
                bottom: 300 + genderController.floatAnimation2.value * 18,
                left: 20,
                child: _buildFloatingShape(
                  size: 90,
                  colors: [Colors.teal.withValues(alpha: 0.08), Colors.transparent],
                  rotation: genderController.rotationAnimation.value * 0.6,
                ),
              ),
              // Sparkle effects
              Positioned(
                top: 150,
                left: 60 + genderController.floatAnimation1.value * 10,
                child: _buildSparkle(size: 8),
              ),
              Positioned(
                top: 400,
                right: 80 + genderController.floatAnimation2.value * 12,
                child: _buildSparkle(size: 6),
              ),
              Positioned(
                bottom: 200,
                left: 100 + genderController.floatAnimation1.value * 8,
                child: _buildSparkle(size: 10),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFloatingShape({
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
          gradient: RadialGradient(colors: colors, stops: const [0.0, 1.0]),
        ),
      ),
    );
  }

  Widget _buildSparkle({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
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
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
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
          const SizedBox(height: 40),
          _buildTitle(),
          const SizedBox(height: 12),
          _buildSubtitle(),
          const Spacer(),
          _buildGenderOptions(),
          const Spacer(),
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
        _buildProgressDot(isActive: false),
        _buildProgressLine(),
        _buildProgressDot(isActive: false),
        _buildProgressLine(),
        _buildProgressDot(isActive: false),
      ],
    );
  }

  Widget _buildProgressDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
                  blurRadius: 8,
                  spreadRadius: 1,
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
      color: Colors.white.withValues(alpha: 0.2),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildTitle() {
    return Text(
      "What's your gender?",
      style: GoogleFonts.fredoka(
        fontSize: 32,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Help us personalize your experience\nby selecting your gender",
      style: GoogleFonts.fredoka(
        fontSize: 16,
        color: Colors.white.withOpacity(0.7),
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildGenderOptions() {
    return Obx(
      () => Column(
        children: [
          _buildGenderCard(
            gender: 'male',
            title: 'Male',
            icon: Icons.male,
            gradient: [
              Colors.blue.withValues(alpha: 0.8),
              Colors.cyan.withValues(alpha: 0.6),
            ],
            isSelected: genderController.selectedGender.value == 'male',
          ),
          const SizedBox(height: 20),
          _buildGenderCard(
            gender: 'female',
            title: 'Female',
            icon: Icons.female,
            gradient: [
              Colors.pink.withValues(alpha: 0.8),
              Colors.purple.withValues(alpha: 0.6),
            ],
            isSelected: genderController.selectedGender.value == 'female',
          ),
          const SizedBox(height: 20),
          _buildGenderCard(
            gender: 'other',
            title: 'Other',
            icon: Icons.transgender,
            gradient: [
              Colors.green.withValues(alpha: 0.8),
              Colors.teal.withValues(alpha: 0.6),
            ],
            isSelected: genderController.selectedGender.value == 'other',
          ),
          const SizedBox(height: 20),
          _buildGenderCard(
            gender: 'prefer_not_to_say',
            title: 'Prefer not to say',
            icon: Icons.help_outline,
            gradient: [
              Colors.orange.withValues(alpha: 0.8),
              Colors.amber.withValues(alpha: 0.6),
            ],
            isSelected:
                genderController.selectedGender.value == 'prefer_not_to_say',
          ),
        ],
      ),
    );
  }

  Widget _buildGenderCard({
    required String gender,
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => genderController.selectGender(gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: gradient,
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.08),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.4)
                : Colors.white.withOpacity(0.15),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: gradient.first.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                border: Border.all(
                  color: Colors.white.withOpacity(isSelected ? 0.4 : 0.2),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.fredoka(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, color: gradient.first, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Obx(
      () => AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: genderController.selectedGender.value.isNotEmpty ? 1.0 : 0.5,
        child: CustomButton(
          ontap: () {},
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
                turns: genderController.selectedGender.value.isNotEmpty
                    ? 0
                    : 0.5,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
