import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/utils/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final userController = Get.find<UserController>();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.usersWhoLikesMeList.isNotEmpty) return;
      userController.getUserWhoLikesMe();
    });
  }

  @override
  void dispose() {
    userController.isloading.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          decoration: AuthWidgets().buildBackgroundDecoration(),
          child: Obx(() {
            if (userController.isloading.value) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }
            if (userController.usersWhoLikesMeList.isEmpty) {
              return Center(
                child: Text(
                  "No users found",
                  style: GoogleFonts.figtree(
                    fontSize: 22,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }
            return buildGridBuilder();
          }),
        ),
      ),
    );
  }

  Padding buildGridBuilder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GridView.builder(
        itemCount: userController.usersWhoLikesMeList.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final user = userController.usersWhoLikesMeList[index];
          return buildLikeCard(user: user);
        },
      ),
    );
  }

  Widget buildLikeCard({required UserModel user}) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.swipeProfile, arguments: {'userId': user.id});
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: user.avatar ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: Color(0xFF1A1625),
                    highlightColor: Color(0xFFD586D3),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF1A1625),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error, color: AppColors.primaryColor),
                ),
              ),
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
                  "${user.fullName?.split(" ").first},  ${calculateAge(user.dob)}",
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
                      user.location?.address ?? "",
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
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF1A1625),
      title: Text(
        "Likes",
        style: GoogleFonts.fredoka(
          fontSize: 22,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications, color: AppColors.primaryColor),
        ),
      ],
    );
  }

}
