import 'package:falangthai/app/controller/language_controller.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LanguageScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> floatAnimation;
  
  final RxString selectedLanguage = ''.obs;
  final RxBool isLoading = false.obs;
  
  final List<Map<String, String>> languages = [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇺🇸',
    },
    {
      'code': 'th',
      'name': 'Thai',
      'nativeName': 'ภาษาไทย',
      'flag': '🇹🇭',
    },
    {
      'code': 'fr',
      'name': 'French',
      'nativeName': 'Français',
      'flag': '🇫🇷',
    },
  ];
  
  final List<String> backgroundImages = [
    'assets/images/pic1.jpeg',
    'assets/images/pic2.jpg',
    'assets/images/pic3.jpg',
    'assets/images/pic4.jpg',
    'assets/images/pic5.jpg',
    'assets/images/pic6.jpg',
    'assets/images/pic7.jpg',
    'assets/images/pic8.jpg',
    'assets/images/pic9.jpg',
    'assets/images/pic10.jpg',
    'assets/images/pic11.jpg',
    'assets/images/pic12.jpg',
    'assets/images/pic13.jpg',
    'assets/images/pic14.jpg',
    'assets/images/pic15.jpg',
    'assets/images/pic16.jpg',
    'assets/images/pic17.jpg',
    'assets/images/pic18.jpg',
    'assets/images/pic19.jpg',
    'assets/images/pic20.jpg',
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _detectSystemLanguage();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    floatAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    animationController.repeat(reverse: true);
  }

  void _detectSystemLanguage() {
    // Auto-select based on system locale
    final systemLocale = Get.deviceLocale?.languageCode ?? 'en';
    final supportedLanguage = languages.firstWhere(
      (lang) => lang['code'] == systemLocale,
      orElse: () => languages.first,
    );
    selectedLanguage.value = supportedLanguage['code']!;
  }

  void selectLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    HapticFeedback.lightImpact();
  }

  void continueToNext() {
    if (selectedLanguage.value.isEmpty) return;
    final languageController = Get.find<LanguageController>();
    languageController.saveLanguage(selectedLanguage.value);
    Get.toNamed(AppRoutes.signup);
  }

  Future<void> saveSelectedLanguage() async {
    // Save to SharedPreferences or local database
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('selected_language', selectedLanguage.value);
    
    // For now, just simulate the save operation
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> updateAppLocale() async {
    final selectedLang = languages.firstWhere(
      (lang) => lang['code'] == selectedLanguage.value,
    );
    
    // Update GetX locale
    final locale = Locale(selectedLang['code']!);
    await Get.updateLocale(locale);
  }

  String get selectedLanguageName {
    final lang = languages.firstWhere(
      (lang) => lang['code'] == selectedLanguage.value,
      orElse: () => languages.first,
    );
    return lang['name']!;
  }

  String get selectedLanguageNativeName {
    final lang = languages.firstWhere(
      (lang) => lang['code'] == selectedLanguage.value,
      orElse: () => languages.first,
    );
    return lang['nativeName']!;
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}