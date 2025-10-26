// import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/controller/language_controller.dart';
import 'package:falangthai/app/controller/socket_controller.dart';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: -50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.bounceOut),
      ),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () async {
      final authController = Get.find<AuthController>();
      final storageController = Get.find<StorageController>();
      final languageController = Get.find<LanguageController>();

      final lanCode = languageController.locale.value;
      String? token = await storageController.getToken();

      if ((token == null || token.isEmpty) && lanCode == null) {
        Get.offAllNamed(AppRoutes.welcome);
        return;
      }
      if ((token == null || token.isEmpty) && lanCode != null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }
    
      await authController.handleLoginNavigation();
      final socketController = Get.find<SocketController>();
      await socketController.initializeSocket();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: AppColors.primaryColor),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _bounceAnimation.value),
                child: Opacity(
                  opacity: fadeAnimation.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "FalangThai",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
