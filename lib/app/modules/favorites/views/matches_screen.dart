

import 'dart:ui';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchesScreen extends StatelessWidget {
  MatchesScreen({super.key});


  final List<String> images = [
    "assets/images/pic1.jpeg",
    "assets/images/pic2.jpg",
    "assets/images/pic3.jpg",
    "assets/images/pic4.jpg",
    "assets/images/pic5.jpg",
    "assets/images/pic6.jpg",
    "assets/images/pic7.jpg",
    "assets/images/pic8.jpg",
    "assets/images/pic9.jpg",
    "assets/images/pic10.jpg",
    "assets/images/pic11.jpg",
    "assets/images/pic12.jpg",
    "assets/images/pic13.jpg",
    "assets/images/pic14.jpg",
    "assets/images/pic15.jpg",
    "assets/images/pic16.jpg",
    "assets/images/pic17.jpg",
    "assets/images/pic18.jpg",
    "assets/images/pic19.jpg",
    "assets/images/pic20.jpg",
    "assets/images/pic21.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          decoration: AuthWidgets().buildBackgroundDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              itemCount: images.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final image = images[index];
                return buildLikeCard(image);
              },
            ),
          ),
        ),
      ),
    );
  }

  Stack buildLikeCard(String image) {
    return Stack(
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
                  height: Get.height * 0.07,
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Blaire  23",
                style: GoogleFonts.figtree(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 15),
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
              SizedBox(height: 6),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(
              FontAwesomeIcons.solidHeart,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF1A1625),
      title: Text(
        "Matches",
        style: GoogleFonts.fredoka(
          fontSize: 22,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.filter_alt, color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
