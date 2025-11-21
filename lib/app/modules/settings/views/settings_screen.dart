import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: AuthWidgets().buildBackgroundDecoration(),
          child: ListView(
            children: [
              buildTitle(icon: Icons.person, title: text.settingsSectionGeneral),

              buildText(
                title: text.settingsEditProfile,
                icon: Icons.person,
                onTap: () => Get.toNamed(AppRoutes.profile),
              ),

              buildText(
                title: text.settingsWallet,
                icon: Icons.wallet,
                onTap: () => Get.toNamed(AppRoutes.walletScreen),
              ),

              buildText(
                title: text.settingsLanguage,
                icon: FontAwesomeIcons.language,
                onTap: () => Get.toNamed(
                  AppRoutes.language,
                  arguments: {'onContinue': () => Get.back()},
                ),
              ),

              buildText(
                title: text.settingsInvite,
                icon: FontAwesomeIcons.usersRays,
                onTap: () => Get.toNamed(AppRoutes.inviteStat),
              ),

              // buildText(
              //   title: "Notification",
              //   icon: Icons.notifications,
              //   onTap: () => Get.toNamed(AppRoutes.notification),
              // ),
              buildText(
                title: text.settingsSecurity,
                icon: Icons.security,
                onTap: () => Get.toNamed(AppRoutes.changePasswordScreen),
              ),
              SizedBox(height: 20),
              buildTitle(title: text.settingsSectionSupport, icon: Icons.support),
              buildText(
                title: text.settingsSubscription,
                icon: Icons.subscript,
                onTap: () => Get.toNamed(AppRoutes.subscription),
              ),
              buildText(
                title: text.settingsPrivacy,
                icon: Icons.privacy_tip,
                onTap: () => Get.toNamed(AppRoutes.privacyPolicyScreen),
              ),
              buildText(
                title: text.settingsTermsAndConditions,
                icon: Icons.policy,
                onTap: () => Get.toNamed(AppRoutes.termsAndConditionScreen),
              ),
              // buildText(title: "Help Center", icon: Icons.help_center),
              SizedBox(height: 20),
              buildTitle(icon: Icons.manage_accounts, title: text.settingsSectionAccount),
              buildText(
                title: text.settingsReportProblem,
                icon: Icons.report,
                onTap: () => Get.toNamed(AppRoutes.supportScreen),
              ),
              buildText(
                title: text.settingsLogout,
                icon: Icons.logout,
                prefixColor: Colors.red,
                onTap: () async {
                  Get.offAllNamed(AppRoutes.login);
                  await Get.find<AuthController>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        AppLocalizations.of(Get.context!)!.settingsTitle,
        style: GoogleFonts.fredoka(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: AppColors.primaryColor,
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF1A1625),
      centerTitle: true,
    );
  }

  ListTile buildText({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    Color? prefixColor,
  }) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 12,
      minTileHeight: 45,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: prefixColor ?? AppColors.primaryColor),
      title: Text(
        title,
        style: GoogleFonts.fredoka(
          fontSize: 16,
          color: const Color.fromARGB(255, 255, 249, 254),
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
    );
  }

  Widget buildTitle({required IconData icon, required String title}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primaryColor),
            SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        Divider(color: Colors.white.withOpacity(0.3)),
      ],
    );
  }
}
