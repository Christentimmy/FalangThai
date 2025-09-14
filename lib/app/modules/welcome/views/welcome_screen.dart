import 'dart:math' as math;

import 'package:falangthai/app/modules/welcome/controller/welcome_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final welcomeController = Get.put(WelcomeController());

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildBouncingLogo(),
        Center(
          child: Text(
            "Inclusive,reliable and safe",
            style: GoogleFonts.fredoka(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            "Go beyond your social circle & connect with\npeople who share your interests",
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomButton(
            ontap: () {
              Get.toNamed(AppRoutes.language);
            },
            isLoading: false.obs,
            borderRadius: BorderRadius.circular(24),
            child: Text(
              "Get Started",
              style: GoogleFonts.fredoka(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: GoogleFonts.fredoka(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Login",
              style: GoogleFonts.fredoka(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  AnimatedBuilder _buildBouncingLogo() {
    return AnimatedBuilder(
      animation: welcomeController.animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, welcomeController.bounceAnimation.value),
          child: child,
        );
      },
      child: Center(
        child: Transform.rotate(
          angle: math.pi / 0.53,
          child: Image.asset(
            "assets/images/logo.png",
            width: 110,
            height: 80,
            fit: BoxFit.cover,
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
            colors: [Colors.transparent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.3, 0.5],
          ),
        ),
      ),
    );
  }

  MasonryGridView _buildStaggeredPictures() {
    return MasonryGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 5,
      crossAxisSpacing: 8,
      itemCount: welcomeController.images.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
      itemBuilder: (context, index) {
        final images = welcomeController.images[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(images, fit: BoxFit.cover),
        );
      },
    );
  }
}
