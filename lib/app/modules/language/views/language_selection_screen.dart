import 'dart:math' as math;
import 'dart:ui';

import 'package:falangthai/app/modules/language/controller/language_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageSelectionScreen extends StatelessWidget {
  LanguageSelectionScreen({super.key});

  final languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 45, 51),
      body: Stack(
        children: [
          _buildStaggeredPictures(),
          _buildColorsOverlay(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFloatingLogo(),
                  const SizedBox(height: 40),
                  _buildTitle(),
                  const SizedBox(height: 12),
                  _buildSubtitle(),
                  const SizedBox(height: 40),
                  _buildLanguageList(),
                  const SizedBox(height: 30),
                  _buildContinueButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "Skip",
            style: GoogleFonts.fredoka(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingLogo() {
    return AnimatedBuilder(
      animation: languageController.animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, languageController.floatAnimation.value * 8),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.3),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Transform.rotate(
          angle: math.pi / 0.53,
          child: Image.asset(
            "assets/images/logo.png",
            width: 60,
            height: 45,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Choose Your Language",
      style: GoogleFonts.fredoka(
        fontSize: 28,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Select your preferred language for the\nbest experience",
      textAlign: TextAlign.center,
      style: GoogleFonts.fredoka(
        fontSize: 16,
        color: Colors.grey.shade300,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildLanguageList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.3),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: languageController.languages.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: Colors.white.withOpacity(0.1)),
            itemBuilder: (context, index) {
              final language = languageController.languages[index];
              // final isSelected =
              //     languageController.selectedLanguage.value == language['code'];

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  onTap: () {
                    languageController.selectLanguage(language['code']!);
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        language['flag'] ?? "",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    language['name'] ?? "",
                    style: GoogleFonts.fredoka(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    language['nativeName'] ?? "",
                    style: GoogleFonts.fredoka(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              languageController.selectedLanguage.value ==
                                  language['code']
                              ? AppColors.primaryColor
                              : Colors.grey.shade500,
                          width: 2,
                        ),
                        color:
                            languageController.selectedLanguage.value ==
                                language['code']
                            ? AppColors.primaryColor
                            : Colors.transparent,
                      ),
                      child:
                          languageController.selectedLanguage.value ==
                              language['code']
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Obx(
      () => Opacity(
        opacity: languageController.selectedLanguage.value.isNotEmpty
            ? 1.0
            : 0.6,
        child: CustomButton(
          ontap: languageController.selectedLanguage.value.isNotEmpty
              ? () => languageController.continueToNext()
              : () {},
          isLoading: languageController.isLoading,
          borderRadius: BorderRadius.circular(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Continue",
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorsOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.8), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.5],
          ),
        ),
      ),
    );
  }

  Widget _buildStaggeredPictures() {
    return MasonryGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 5,
      crossAxisSpacing: 8,
      itemCount: languageController.backgroundImages.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
      itemBuilder: (context, index) {
        final images = languageController.backgroundImages[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(images, fit: BoxFit.cover),
        );
      },
    );
  }
}
