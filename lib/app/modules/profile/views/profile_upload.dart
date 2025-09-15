import 'package:falangthai/app/modules/profile/controllers/profile_upload_controller.dart';
import 'package:falangthai/app/modules/profile/widgets/profile_upload_widget.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfileUploadScreen extends StatelessWidget {
  ProfileUploadScreen({super.key});

  final profileController = Get.put(ProfileUploadController());
  final profileUploadWidget = ProfileUploadWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: profileUploadWidget.buildBackgroundDecoration(),
        child: SafeArea(
          child: Stack(
            children: [
              profileUploadWidget.buildAnimatedBackground(),
              _buildContent(),
              profileUploadWidget.buildHeader(),
            ],
          ),
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
          profileUploadWidget.buildProgressIndicator(),
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
        opacity: profileController.isValid ? 1.0 : 0.5,
        child: CustomButton(
          ontap: () {
            if (!profileController.isValid) return;
            Get.toNamed(AppRoutes.hobby);
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
