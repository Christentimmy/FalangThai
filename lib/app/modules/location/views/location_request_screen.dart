import 'package:falangthai/app/controller/location_controller.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationRequestScreen extends StatelessWidget {
  final VoidCallback? nextScreen;
  LocationRequestScreen({super.key, this.nextScreen});

  final locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        decoration: AuthWidgets().buildBackgroundDecoration(),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.02),
            Text(
              text.locationRequestTitle,
              style: GoogleFonts.fredoka(
                fontSize: 24,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Text(
              text.locationRequestBody,
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
                text.allowLocation,
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
