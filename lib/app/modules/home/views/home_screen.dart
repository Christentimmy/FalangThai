import 'dart:ui';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:falangthai/app/modules/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(HomeController());
  final authWidget = AuthWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: authWidget.buildBackgroundDecoration(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                SizedBox(height: Get.height * 0.05),
                Expanded(
                  child: AppinioSwiper(
                    cardCount: homeController.images.length,
                    backgroundCardCount: 2,
                    backgroundCardOffset: Offset(0, -45),
                    onSwipeEnd: (previousIndex, targetIndex, activity) {
                      // Get.toNamed(AppRoutes.match);
                    },
                    cardBuilder: (context, index) {
                      final image = homeController.images[index];
                      return buildCard(image: image);
                    },
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildCard({required String image}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: Get.height * 0.18,
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "Blaire  23",
                      style: GoogleFonts.figtree(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Icon(
                        FontAwesomeIcons.circleExclamation,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white),
                    Text(
                      "5 miles away",
                      style: GoogleFonts.figtree(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  "“I’ll fall for you if you love dogs 🐶 and good jollof rice 🍛.” Christian girlie!! I think I hate skating too.",
                  style: GoogleFonts.figtree(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildActionButton(icon: FontAwesomeIcons.arrowsRotate, onTap: () {}),
        buildActionButton(size: 35, icon: FontAwesomeIcons.xmark, onTap: () {}),
        buildActionButton(
          icon: FontAwesomeIcons.solidHeart,
          onTap: () {},
          size: 35,
        ),
        buildActionButton(icon: FontAwesomeIcons.paperPlane, onTap: () {}),
      ],
    );
  }

  Row buildHeader() {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Falang",
              style: GoogleFonts.fredoka(
                fontSize: 22,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Thai",
              style: GoogleFonts.fredoka(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () => Get.toNamed(AppRoutes.notification),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.notifications, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  Widget buildActionButton({
    required IconData icon,
    VoidCallback? onTap,
    double? size,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          radius: size ?? 30,
          child: Icon(icon, color: Get.theme.primaryColor),
        ),
      ),
    );
  }
}
