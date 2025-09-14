import 'package:falangthai/app/modules/intro/views/intro_screen.dart';
import 'package:falangthai/app/modules/splash/splash_screen.dart';
import 'package:falangthai/app/modules/welcome/views/welcome_screen.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.intro,
      page: () => const IntroScreen(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () =>  WelcomeScreen(),
    ),
  ]; 
}