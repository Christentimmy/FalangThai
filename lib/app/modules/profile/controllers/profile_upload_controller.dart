import 'dart:io';
import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUploadController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController backgroundAnimationController;
  final bioController = TextEditingController();

  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;

  // Observable States
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<DateTime?> dateOfBirth = Rx<DateTime?>(null);
  final RxBool showUploadOptions = false.obs;

  // Upload progress
  final isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Background animations with longer duration for smoother effect
    backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    );

    floatAnimation1 = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    floatAnimation2 = Tween<double>(begin: 1.0, end: -1.0).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );

    rotationAnimation =
        Tween<double>(
          begin: 0,
          end: 6.28318530718, // 2π
        ).animate(
          CurvedAnimation(
            parent: backgroundAnimationController,
            curve: Curves.linear,
          ),
        );

    pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    backgroundAnimationController.repeat();
  }

  void showImagePickerOptions() {
    HapticFeedback.mediumImpact();
    showUploadOptions.value = !showUploadOptions.value;

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1F1B2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Choose Photo Source",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomSheetOption(
                  icon: Icons.camera_alt_rounded,
                  label: "Camera",
                  onTap: () {
                    Get.back();
                    pickImageFromCamera();
                  },
                ),
                _buildBottomSheetOption(
                  icon: Icons.photo_library_rounded,
                  label: "Gallery",
                  onTap: () {
                    Get.back();
                    pickImageFromGallery();
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromCamera() async {
    try {
      HapticFeedback.lightImpact();

      final image = await pickImage(imageSource: ImageSource.camera);

      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      _showErrorSnackbar("Failed to capture image from camera");
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      HapticFeedback.lightImpact();

      final image = await pickImage();

      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      _showErrorSnackbar("Failed to select image from gallery");
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }

  // Validation
  bool get hasSelectedImage => selectedImage.value != null;
  bool get hasSelectedDateOfBirth => dateOfBirth.value != null;
  bool get isBioValid => bioController.text.isNotEmpty;

  RxBool isValid = false.obs;

  void validate() {
    isValid.value = hasSelectedImage && hasSelectedDateOfBirth && isBioValid;
  }

  void showDateDialog() async {
    final date = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime(1940),
      initialDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.dark(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      dateOfBirth.value = date;
    }
  }

  Future<void> uploadImageAndDob({VoidCallback? nextScreen}) async {
    isloading.value = true;
    try {
      if (!isValid.value) return;
      final authController = Get.find<AuthController>();
      final userModel = UserModel(
        dob: dateOfBirth.value!.toIso8601String(),
        bio: bioController.text,
      );
      if (selectedImage.value == null) return;
      await authController.completeProfile(
        userModel: userModel,
        imageFile: selectedImage.value!,
        nextScreen: nextScreen,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  @override
  void onClose() {
    backgroundAnimationController.dispose();
    super.onClose();
  }
}
