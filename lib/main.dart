import 'package:app_links/app_links.dart';
import 'package:falangthai/app/bindings/app_bindings.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/resources/supported_locales.dart';
import 'package:falangthai/app/routes/app_pages.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AppLinks _appLinks = AppLinks();

  final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.initDeepLinks(_appLinks);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "FalangThai",
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      initialBinding: AppBindings(),
      locale: Locale("fr"),
      fallbackLocale: Locale("fr"),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        primaryColor: Colors.pinkAccent,
        textTheme: GoogleFonts.poppinsTextTheme(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
          selectionHandleColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
