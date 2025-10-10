import 'package:falangthai/app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PreferenceItem {
  final String id;
  final String title;
  final IconData icon;

  PreferenceItem({required this.id, required this.title, required this.icon});
}

class RelationshipPreferenceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController backgroundAnimationController;

  final isloading = false.obs;

  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;
  late Animation<double> heartbeatAnimation;

  // Observable States
  final RxString selectedPreference = ''.obs;

  final List<PreferenceItem> genderPreferences = [
    PreferenceItem(id: 'men', title: 'Men', icon: Icons.male_rounded),
    PreferenceItem(id: 'women', title: 'Women', icon: Icons.female_rounded),
    PreferenceItem(
      id: 'non_binary',
      title: 'Non-binary',
      icon: Icons.transgender_rounded,
    ),
    PreferenceItem(
      id: 'transgender',
      title: 'Transgender',
      icon: Icons.wc_rounded,
    ),
    PreferenceItem(
      id: 'everyone',
      title: 'Everyone',
      icon: Icons.favorite_rounded,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 35),
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
        curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
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

    pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    heartbeatAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: const Interval(0.0, 0.1, curve: Curves.easeInOut),
      ),
    );

    backgroundAnimationController.repeat();
  }

  void toggleGenderPreference(String preferenceId) {
    HapticFeedback.lightImpact();
    if (selectedPreference.value == preferenceId) {
      selectedPreference.value = '';
    } else {
      selectedPreference.value = preferenceId;
    }
  }

  bool get canContinue {
    return selectedPreference.value.isNotEmpty;
  }

  Future<void> updatePreference({VoidCallback? nextScreen}) async {
    isloading.value = true;
    try {
      if (!canContinue) return;
      final userController = Get.find<UserController>();
      await userController.updateInterestIn(
        interestedIn: selectedPreference.value,
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
