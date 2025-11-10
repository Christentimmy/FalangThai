import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.fredoka(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryColor,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1A1625),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: AuthWidgets().buildBackgroundDecoration(),
          child: ListView(
            children: [
              buildTitle(icon: Icons.person, title: "General"),

              buildText(
                title: "Edit Profile",
                icon: Icons.person,
                onTap: () => Get.toNamed(AppRoutes.profile),
              ),

              buildText(
                title: "Language",
                icon: FontAwesomeIcons.language,
                onTap: () => Get.toNamed(AppRoutes.language),
              ),

              buildText(
                title: "Invite",
                icon: FontAwesomeIcons.usersRays,
                onTap: () => Get.toNamed(AppRoutes.inviteStat),
              ),

              buildText(
                title: "Notification",
                icon: Icons.notifications,
                onTap: () => Get.toNamed(AppRoutes.notification),
              ),
              buildText(title: "Security", icon: Icons.security),
              buildText(title: "Privacy", icon: Icons.privacy_tip),
              SizedBox(height: 20),
              buildTitle(title: "Support", icon: Icons.support),
              buildText(
                title: "Subscription",
                icon: Icons.subscript,
                onTap: () => Get.toNamed(AppRoutes.subscription),
              ),
              buildText(title: "Terms & Conditions", icon: Icons.policy),
              buildText(title: "Help Center", icon: Icons.help_center),
              SizedBox(height: 20),
              buildTitle(icon: Icons.manage_accounts, title: "Account"),
              buildText(title: "Report a problem", icon: Icons.report),
              buildText(
                title: "Logout",
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
