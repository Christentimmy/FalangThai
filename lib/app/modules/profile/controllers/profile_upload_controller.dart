import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUploadController extends GetxController with GetSingleTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController backgroundAnimationController;
  
  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;
  
  // Observable States
  final RxString selectedImagePath = ''.obs;
  final RxBool isUploading = false.obs;
  final RxBool showUploadOptions = false.obs;
  
  // Image picker
  final ImagePicker _imagePicker = ImagePicker();
  
  // Upload progress
  final RxDouble uploadProgress = 0.0.obs;

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
    
    floatAnimation1 = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: backgroundAnimationController,
      curve: Curves.easeInOut,
    ));
    
    floatAnimation2 = Tween<double>(
      begin: 1.0,
      end: -1.0,
    ).animate(CurvedAnimation(
      parent: backgroundAnimationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
    ));
    
    rotationAnimation = Tween<double>(
      begin: 0,
      end: 6.28318530718, // 2π
    ).animate(CurvedAnimation(
      parent: backgroundAnimationController,
      curve: Curves.linear,
    ));
    
    pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: backgroundAnimationController,
      curve: Curves.easeInOut,
    ));
    
    backgroundAnimationController.repeat();
  }

  void showImagePickerOptions() {
    HapticFeedback.mediumImpact();
    showUploadOptions.value = !showUploadOptions.value;
    
    Get.bottomSheet(
      Container(
        height: 200,
        decoration: const BoxDecoration(
          color: Color(0xFF1F1B2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
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
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
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
      
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      
      if (image != null) {
        await _processSelectedImage(image.path);
      }
    } catch (e) {
      _showErrorSnackbar("Failed to capture image from camera");
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      HapticFeedback.lightImpact();
      
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      
      if (image != null) {
        await _processSelectedImage(image.path);
      }
    } catch (e) {
      _showErrorSnackbar("Failed to select image from gallery");
    }
  }

  Future<void> _processSelectedImage(String imagePath) async {
    isUploading.value = true;
    uploadProgress.value = 0.0;
    
    try {
      // Simulate upload progress
      for (int i = 0; i <= 100; i += 10) {
        uploadProgress.value = i / 100;
        await Future.delayed(const Duration(milliseconds: 50));
      }
      
      selectedImagePath.value = imagePath;
      HapticFeedback.lightImpact();
      
      Get.snackbar(
        "Success",
        "Photo uploaded successfully!",
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
      
    } catch (e) {
      _showErrorSnackbar("Failed to process image");
    } finally {
      isUploading.value = false;
      uploadProgress.value = 0.0;
    }
  }

  void removeImage() {
    HapticFeedback.mediumImpact();
    selectedImagePath.value = '';
    
    Get.snackbar(
      "Removed",
      "Photo removed successfully",
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }

  void continueToNext() {
    if (selectedImagePath.value.isNotEmpty) {
      HapticFeedback.lightImpact();
      // Navigate to next screen
      // Get.to(() => NextScreen());
      
      Get.snackbar(
        "Success",
        "Profile photo saved! Moving to next step...",
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
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
  bool get hasSelectedImage => selectedImagePath.value.isNotEmpty;
  bool get canContinue => hasSelectedImage && !isUploading.value;

  @override
  void onClose() {
    backgroundAnimationController.dispose();
    super.onClose();
  }
}