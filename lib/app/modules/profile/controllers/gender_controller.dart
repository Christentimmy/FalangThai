import 'package:falangthai/app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GenderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController backgroundAnimationController;

  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;

  // Observable States
  final RxString selectedGender = ''.obs;
  final RxBool isLoading = false.obs;

  // Gender options with metadata
  final List<Map<String, dynamic>> genderOptions = [
    {
      'id': 'male',
      'title': 'Male',
      'icon': Icons.male,
      'gradient': [Colors.blue.withOpacity(0.8), Colors.cyan.withOpacity(0.6)],
      'description': 'Identifies as male',
    },
    {
      'id': 'female',
      'title': 'Female',
      'icon': Icons.female,
      'gradient': [
        Colors.pink.withOpacity(0.8),
        Colors.purple.withOpacity(0.6),
      ],
      'description': 'Identifies as female',
    },
    {
      'id': 'other',
      'title': 'Other',
      'icon': Icons.transgender,
      'gradient': [Colors.green.withOpacity(0.8), Colors.teal.withOpacity(0.6)],
      'description': 'Non-binary or other gender identity',
    },
    {
      'id': 'prefer_not_to_say',
      'title': 'Prefer not to say',
      'icon': Icons.help_outline,
      'gradient': [
        Colors.orange.withOpacity(0.8),
        Colors.amber.withOpacity(0.6),
      ],
      'description': 'Prefers to keep gender private',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Background animations
    backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 30),
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
        curve: const Interval(0.1, 1.0, curve: Curves.easeInOut),
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

    backgroundAnimationController.repeat();
  }

  void selectGender(String gender) {
    HapticFeedback.lightImpact();
    selectedGender.value = gender;
  }

  IconData get selectedGenderIcon {
    if (selectedGender.value.isEmpty) return Icons.help_outline;

    final option = genderOptions.firstWhere(
      (g) => g['id'] == selectedGender.value,
      orElse: () => {'icon': Icons.help_outline},
    );

    return option['icon'] ?? Icons.help_outline;
  }

  List<Color> get selectedGenderGradient {
    if (selectedGender.value.isEmpty) {
      return [Colors.grey, Colors.grey.shade600];
    }

    final option = genderOptions.firstWhere(
      (g) => g['id'] == selectedGender.value,
      orElse: () => {
        'gradient': [Colors.grey, Colors.grey.shade600],
      },
    );

    return option['gradient'] as List<Color>;
  }

  void resetSelection() {
    selectedGender.value = '';
  }

  bool get isSelectionValid => selectedGender.value.isNotEmpty;

  Future<void> saveGender() async {
    if (!isSelectionValid) return;
    isLoading.value = true;
    final userController = Get.find<UserController>();
    await userController.updateGender(gender: selectedGender.value);
    isLoading.value = false;
  }

  @override
  void onClose() {
    backgroundAnimationController.dispose();
    super.onClose();
  }
}
