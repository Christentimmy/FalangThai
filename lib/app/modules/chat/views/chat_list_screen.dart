import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          decoration: AuthWidgets().buildBackgroundDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                _buildStory(),
                SizedBox(height: Get.height * 0.01),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return buildChatTile();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF1A1625),
      title: Text(
        "Chats",
        style: GoogleFonts.figtree(
          fontSize: 25,
          fontWeight: FontWeight.w800,
          color: Get.theme.primaryColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: AppColors.primaryColor),
        ),
      ],
    );
  }

  ListTile buildChatTile() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 5,
      onTap: () {
        Get.toNamed(AppRoutes.message);
      },
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage("assets/images/pic9.jpg"),
      ),
      title: Text(
        "Jessica sent you a text",
        style: GoogleFonts.fredoka(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        "2 hours ago",
        style: GoogleFonts.fredoka(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "22:40",
            style: GoogleFonts.figtree(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Get.theme.primaryColor,
            ),
          ),
          SizedBox(height: 2),
          CircleAvatar(
            radius: 10,
            backgroundColor: AppColors.primaryColor,
            child: Text(
              "2",
              style: GoogleFonts.figtree(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStory() {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      height: Get.height * 0.088,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Get.toNamed(AppRoutes.viewStory);
            },
            child: Stack(
              children: [
                Container(
                  width: Get.width * 0.18,
                  height: Get.height * 0.085,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      "assets/images/pic6.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                index == 0
                    ? Positioned(
                        right: 5,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            // Get.toNamed(AppRoutes.createPost);
                          },
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
