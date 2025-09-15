

import 'package:flutter/material.dart';
import 'package:get/get.dart';



// Profile Controller
class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController backgroundAnimationController;

  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;
  late Animation<double> heartbeatAnimation;

  // Observable States
  final RxBool isEditMode = false.obs;
  final RxMap<String, dynamic> profileData = <String, dynamic>{
    'name': 'Sarah Johnson',
    'bio': 'Love traveling, coffee, and meaningful conversations ✨',
    'age': 25,
  }.obs;

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  // Profile Image
  final Rx<dynamic> profileImage = Rx<dynamic>(null);

  // Interests
  final RxList<String> interests = <String>[
    'Travel',
    'Photography',
    'Coffee',
    'Reading',
    'Yoga',
    'Cooking',
    'Music',
    'Art',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
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
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    rotationAnimation = Tween<double>(begin: 0, end: 6.28318530718).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: Curves.linear,
      ),
    );

    pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    heartbeatAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: const Interval(0.0, 0.15, curve: Curves.easeInOut),
      ),
    );

    backgroundAnimationController.repeat();
  }


  @override
  void onClose() {
    backgroundAnimationController.dispose();
    nameController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
