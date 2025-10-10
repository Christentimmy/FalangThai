import 'package:falangthai/app/controller/location_controller.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationRequestScreen extends StatelessWidget {
  final VoidCallback? nextScreen;
  LocationRequestScreen({super.key, this.nextScreen});

  final locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        decoration: AuthWidgets().buildBackgroundDecoration(),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.02),
            Text(
              "Location Request",
              style: GoogleFonts.fredoka(
                fontSize: 24,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'To help you find meaningful connections nearby, we need access to your location. Our dating algorithm uses your location to:\n\n' 
              '• Show you potential matches in your area\n'
              '• Calculate accurate distance between you and other users\n'
              '• Provide better match suggestions based on proximity\n'
              '• Enable location-based features and events\n\n'
              'Your location data is always kept private and encoded.',

              style: GoogleFonts.fredoka(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: Get.height * 0.2),
            CustomButton(
              ontap: () async {
                await locationController.getCurrentCity(nextScreen: nextScreen);
              },
              isLoading: locationController.isloading,
              child: Text(
                "Allow Location",
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
