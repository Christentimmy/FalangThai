

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HobbyItem {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  HobbyItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class HobbiesSelectionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController backgroundAnimationController;

  // Animations
  late Animation<double> floatAnimation1;
  late Animation<double> floatAnimation2;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;

  // Observable States
  final RxList<String> selectedHobbies = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt animationDelay = 0.obs;

  // Available hobbies with beautiful colors
  final List<HobbyItem> availableHobbies = [
    HobbyItem(
      id: 'reading',
      name: 'Reading',
      icon: Icons.menu_book_rounded,
      color: const Color(0xFF6366F1),
    ),
    HobbyItem(
      id: 'music',
      name: 'Music',
      icon: Icons.music_note_rounded,
      color: const Color(0xFFEC4899),
    ),
    HobbyItem(
      id: 'cooking',
      name: 'Cooking',
      icon: Icons.restaurant_rounded,
      color: const Color(0xFFF59E0B),
    ),
    HobbyItem(
      id: 'travel',
      name: 'Travel',
      icon: Icons.flight_rounded,
      color: const Color(0xFF10B981),
    ),
    HobbyItem(
      id: 'photography',
      name: 'Photography',
      icon: Icons.camera_alt_rounded,
      color: const Color(0xFF8B5CF6),
    ),
    HobbyItem(
      id: 'sports',
      name: 'Sports',
      icon: Icons.sports_soccer_rounded,
      color: const Color(0xFFEF4444),
    ),
    HobbyItem(
      id: 'gaming',
      name: 'Gaming',
      icon: Icons.sports_esports_rounded,
      color: const Color(0xFF06B6D4),
    ),
    HobbyItem(
      id: 'art',
      name: 'Art',
      icon: Icons.palette_rounded,
      color: const Color(0xFFF97316),
    ),
    HobbyItem(
      id: 'fitness',
      name: 'Fitness',
      icon: Icons.fitness_center_rounded,
      color: const Color(0xFF84CC16),
    ),
    HobbyItem(
      id: 'movies',
      name: 'Movies',
      icon: Icons.movie_rounded,
      color: const Color(0xFF3B82F6),
    ),
    HobbyItem(
      id: 'dancing',
      name: 'Dancing',
      icon: Icons.music_video_rounded,
      color: const Color(0xFFE11D48),
    ),
    HobbyItem(
      id: 'gardening',
      name: 'Gardening',
      icon: Icons.local_florist_rounded,
      color: const Color(0xFF059669),
    ),
    HobbyItem(
      id: 'writing',
      name: 'Writing',
      icon: Icons.edit_rounded,
      color: const Color(0xFF7C3AED),
    ),
    HobbyItem(
      id: 'tech',
      name: 'Technology',
      icon: Icons.computer_rounded,
      color: const Color(0xFF0891B2),
    ),
    HobbyItem(
      id: 'fashion',
      name: 'Fashion',
      icon: Icons.checkroom_rounded,
      color: const Color(0xFFDB2777),
    ),
    HobbyItem(
      id: 'volunteering',
      name: 'Volunteering',
      icon: Icons.volunteer_activism_rounded,
      color: const Color(0xFF16A34A),
    ),
  ];

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

    rotationAnimation = Tween<double>(
      begin: 0,
      end: 6.28318530718, // 2π
    ).animate(
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

    backgroundAnimationController.repeat();
  }

  void toggleHobby(String hobbyId) {
    HapticFeedback.lightImpact();
    
    if (selectedHobbies.contains(hobbyId)) {
      selectedHobbies.remove(hobbyId);
    } else {
      if (selectedHobbies.length < 8) {
        selectedHobbies.add(hobbyId);
      } else {
        _showMaxSelectionSnackbar();
      }
    }
  }

  void _showMaxSelectionSnackbar() {
    HapticFeedback.mediumImpact();
    Get.snackbar(
      "Maximum Selection",
      "You can select up to 8 hobbies only",
      backgroundColor: const Color(0xFF6366F1).withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: const Color(0xFF6366F1).withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  bool isHobbySelected(String hobbyId) {
    return selectedHobbies.contains(hobbyId);
  }

  bool get canContinue => selectedHobbies.length >= 3;

  String get selectionText {
    final count = selectedHobbies.length;
    if (count == 0) return "Select at least 3 hobbies";
    if (count < 3) return "Select ${3 - count} more hobbies";
    return "$count/8 hobbies selected";
  }

  void continueToNext() {
    if (!canContinue) return;
    
    HapticFeedback.mediumImpact();
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      // Navigate to next screen
      // Get.toNamed('/next-screen');
    });
  }

  @override
  void onClose() {
    backgroundAnimationController.dispose();
    super.onClose();
  }
}