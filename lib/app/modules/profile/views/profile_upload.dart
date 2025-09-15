import 'package:falangthai/app/modules/profile/controllers/profile_upload_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfileUploadScreen extends StatelessWidget {
  ProfileUploadScreen({super.key});

  final profileController = Get.put(ProfileUploadController());

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
          const SizedBox(height: 40),
          _buildTitle(),
          const SizedBox(height: 12),
          _buildSubtitle(),
          const SizedBox(height: 60),
          _buildProfileUploadSection(),
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

  Widget _buildTitle() {
    return Text(
      "Add your photo",
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
      "Show the world your beautiful smile!\nThis helps others recognize you",
      style: GoogleFonts.fredoka(
        fontSize: 16,
        color: Colors.white.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildProfileUploadSection() {
    return Obx(() {
      return Column(
        children: [
          GestureDetector(
            onTap: () => profileController.showImagePickerOptions(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: profileController.selectedImage.value != null
                    ? null
                    : RadialGradient(
                        colors: [
                          AppColors.primaryColor.withValues(alpha: 0.2),
                          Colors.purple.withValues(alpha: 0.1),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.7, 1.0],
                      ),
                border: Border.all(
                  color: profileController.selectedImage.value != null
                      ? AppColors.primaryColor.withValues(alpha: 0.6)
                      : Colors.white.withValues(alpha: 0.3),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: profileController.selectedImage.value != null
                  ? ClipOval(
                      child: Image.file(
                        profileController.selectedImage.value!,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.add_a_photo_rounded,
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
            ),
          ),
          const SizedBox(height: 30),
          // Upload options
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     _buildUploadOption(
          //       icon: Icons.camera_alt_rounded,
          //       label: "Camera",
          //       onTap: () => profileController.pickImageFromCamera(),
          //     ),
          //     _buildUploadOption(
          //       icon: Icons.photo_library_rounded,
          //       label: "Gallery",
          //       onTap: () => profileController.pickImageFromGallery(),
          //     ),
          //   ],
          // ),
          Obx(() {
            final dateOfBirth = profileController.dateOfBirth.value;
            return CustomTextField(
              bgColor: Colors.white.withValues(alpha: 0.05),
              prefixIcon: Icons.person,
              onTap: () => profileController.showDateDialog(),
              prefixIconColor: AppColors.primaryColor,
              readOnly: true,
              hintText: dateOfBirth != null
                  ? DateFormat('dd MMM yyyy').format(dateOfBirth)
                  : "Date of birth",
              hintStyle: GoogleFonts.fredoka(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            );
          }),
        ],
      );
    });
  }

  Widget buildUploadOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withValues(alpha: 0.2),
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.fredoka(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
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
        opacity: profileController.selectedImage.value != null ? 1.0 : 0.5,
        child: CustomButton(
          ontap: () {
            if (!profileController.hasSelectedImage) return;
          },
          isLoading: profileController.isUploading,
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
                turns: profileController.selectedImage.value != null ? 0 : 0.5,
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
