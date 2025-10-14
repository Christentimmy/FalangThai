import 'package:falangthai/app/bindings/app_bindings.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_pages.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}
  
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "FalangThai",
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
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
