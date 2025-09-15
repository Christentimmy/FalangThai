import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1A1625),
        title: Text(
          "Notifications",
          style: GoogleFonts.figtree(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: AuthWidgets().buildBackgroundDecoration(),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 10,
                leading: CircleAvatar(
                  radius: 35,
                  backgroundColor: Color(0xFF542C13),
                  child: Text(
                    "B",
                    style: GoogleFonts.figtree(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(
                  "Your account has been verified",
                  style: GoogleFonts.figtree(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "2 hours ago",
                  style: GoogleFonts.figtree(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(Icons.verified, color: Colors.blue),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 10,
                leading: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/images/pic5.jpg"),
                ),
                title: Text(
                  "Jessica sent you a text",
                  style: GoogleFonts.figtree(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "2 hours ago",
                  style: GoogleFonts.figtree(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(Icons.message, color: Get.theme.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
