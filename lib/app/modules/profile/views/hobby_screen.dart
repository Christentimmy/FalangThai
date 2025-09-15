import 'package:falangthai/app/modules/profile/controllers/hobby_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HobbiesSelectionScreen extends StatelessWidget {
  HobbiesSelectionScreen({super.key});

  final hobbiesController = Get.put(HobbiesSelectionController());

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
        animation: hobbiesController.backgroundAnimationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Main floating orbs with hobby-themed colors
              Positioned(
                top: 80 + hobbiesController.floatAnimation1.value * 30,
                right: 20,
                child: _buildFloatingOrb(
                  size: 180,
                  colors: [
                    const Color(0xFF6366F1).withValues(alpha: 0.15),
                    const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  rotation: hobbiesController.rotationAnimation.value,
                ),
              ),
              Positioned(
                top: 200 + hobbiesController.floatAnimation2.value * 35,
                left: -40,
                child: _buildFloatingOrb(
                  size: 200,
                  colors: [
                    const Color(0xFFEC4899).withValues(alpha: 0.12),
                    const Color(0xFFF97316).withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  rotation: -hobbiesController.rotationAnimation.value * 0.6,
                ),
              ),
              Positioned(
                bottom: 120 + hobbiesController.floatAnimation1.value * 40,
                right: -60,
                child: _buildFloatingOrb(
                  size: 160,
                  colors: [
                    const Color(0xFF10B981).withValues(alpha: 0.12),
                    const Color(0xFF059669).withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  rotation: hobbiesController.rotationAnimation.value * 1.3,
                ),
              ),
              Positioned(
                bottom: 300 + hobbiesController.floatAnimation2.value * 25,
                left: 20,
                child: _buildFloatingOrb(
                  size: 120,
                  colors: [
                    const Color(0xFF06B6D4).withValues(alpha: 0.1),
                    const Color(0xFF0891B2).withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                  rotation: hobbiesController.rotationAnimation.value * 0.4,
                ),
              ),
              // Hobby-themed sparkles
              ...List.generate(12, (index) {
                final colors = [
                  const Color(0xFF6366F1),
                  const Color(0xFFEC4899),
                  const Color(0xFFF59E0B),
                  const Color(0xFF10B981),
                  const Color(0xFF8B5CF6),
                  const Color(0xFFEF4444),
                ];
                return Positioned(
                  top:
                      120 +
                      (index * 60) +
                      hobbiesController.floatAnimation1.value *
                          (8 + index * 1.5),
                  left:
                      60 +
                      (index * 45) +
                      hobbiesController.floatAnimation2.value * (6 + index),
                  child: _buildHobbySparkle(
                    size: 6 + (index % 4) * 2,
                    color: colors[index % colors.length],
                    opacity: 0.5 - (index * 0.03),
                  ),
                );
              }),
              // Floating icons
              ...List.generate(6, (index) {
                final icons = [
                  Icons.music_note_rounded,
                  Icons.palette_rounded,
                  Icons.sports_soccer_rounded,
                  Icons.camera_alt_rounded,
                  Icons.menu_book_rounded,
                  Icons.flight_rounded,
                ];
                return Positioned(
                  top:
                      100 +
                      (index * 120) +
                      hobbiesController.pulseAnimation.value * 10,
                  right: 30 + (index * 30),
                  child: _buildFloatingIcon(
                    icon: icons[index],
                    size: 20 + (index % 3) * 4,
                    opacity: 0.2 - (index * 0.02),
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

  Widget _buildHobbySparkle({
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

  Widget _buildFloatingIcon({
    required IconData icon,
    required double size,
    required double opacity,
  }) {
    return Icon(icon, size: size, color: Colors.white.withOpacity(opacity));
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
          const SizedBox(height: 12),
          _buildSelectionCounter(),
          const SizedBox(height: 30),
          Expanded(child: _buildHobbiesGrid()),
          const SizedBox(height: 12),
          _buildContinueButton(),
          const SizedBox(height: 20),
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

  Widget _buildTitle() {
    return Text(
      "What are your hobbies?",
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
      "Help others discover what makes you unique!\nSelect activities you love and enjoy",
      style: GoogleFonts.fredoka(
        fontSize: 15,
        color: Colors.white.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSelectionCounter() {
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Text(
          hobbiesController.selectionText,
          style: GoogleFonts.fredoka(
            fontSize: 13,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }

  Widget _buildHobbiesGrid() {
    return AnimatedGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.8,
        crossAxisSpacing: 12,
      ),
      initialItemCount: hobbiesController.availableHobbies.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(0.5, 0), end: Offset.zero),
          ),
          child: FadeTransition(
            opacity: animation,
            child: _buildHobbyCard(
              hobby: hobbiesController.availableHobbies[index],
              index: index,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHobbyCard({required HobbyItem hobby, required int index}) {
    return Obx(() {
      final isSelected = hobbiesController.isHobbySelected(hobby.id);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTap: () => hobbiesController.toggleHobby(hobby.id),
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
                Icon(hobby.icon, color: Colors.white70, size: 20),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    hobby.name,
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
        opacity: hobbiesController.canContinue ? 1.0 : 0.5,
        child: CustomButton(
          ontap: hobbiesController.continueToNext,
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
                turns: hobbiesController.canContinue ? 0 : 0.5,
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
