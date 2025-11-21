import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/utils/age_calculator.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:falangthai/app/modules/home/controller/home_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());
  final userController = Get.put(UserController());
  AppinioSwiperController appinioSwiperController = AppinioSwiperController();
  final authWidget = AuthWidgets();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.potentialMatchesList.isNotEmpty) return;
      userController.getPotentialMatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: authWidget.buildBackgroundDecoration(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              buildHeader(),
              SizedBox(height: Get.height * 0.05),
              Expanded(
                child: Obx(() {
                  if (userController.isloading.value) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                  if (userController.potentialMatchesList.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noMatchesFound,
                        style: GoogleFonts.figtree(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }
                  final potentialList = userController.potentialMatchesList;
                  return AppinioSwiper(
                    controller: appinioSwiperController,
                    cardCount: potentialList.length,
                    loop: false,
                    onEnd: () async {
                      await userController.getPotentialMatches(loadMore: true);
                    },
                    backgroundCardOffset: Offset(0, -45),
                    onSwipeEnd: (previousIndex, targetIndex, activity) async {
                      if (previousIndex == -1) return;
                      if (previousIndex >=
                          userController.potentialMatchesList.length) {
                        return;
                      }
                      final userId =
                          userController.potentialMatchesList[previousIndex].id;
                      if (userId == null) return;
                      if (activity.direction == AxisDirection.right) {
                        await userController.swipe(
                          userId: userId,
                          type: SwipeType.like,
                        );
                      }
                      if (activity.direction == AxisDirection.left) {
                        await userController.swipe(
                          userId: userId,
                          type: SwipeType.pass,
                        );
                      }
                      if (activity.direction == AxisDirection.up) {
                        await userController.swipe(
                          userId: userId,
                          type: SwipeType.superlike,
                        );
                      }
                    },
                    cardBuilder: (context, index) {
                      return buildCard(user: potentialList[index]);
                    },
                  );
                }),
              ),
              SizedBox(height: Get.height * 0.01),
              buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard({required UserModel user}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.swipeProfile, arguments: {'userId': user.id});
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: user.avatar ?? "",
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
                  fit: BoxFit.cover,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        "${user.fullName?.split(" ").first} ${calculateAge(user.dob)}",
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
                        user.location?.address?.capitalizeFirst ?? "",
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
                    user.bio?.capitalizeFirst ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
      ),
    );
  }

  Row buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // buildActionButton(
        //   icon: FontAwesomeIcons.arrowsRotate,
        //   onTap: () {
        //     appinioSwiperController.unswipe();
        //   },
        // ),
        buildActionButton(
          icon: FontAwesomeIcons.xmark,
          onTap: () {
            appinioSwiperController.swipeLeft();
          },
        ),
        buildActionButton(
          icon: FontAwesomeIcons.solidHeart,
          onTap: () {
            appinioSwiperController.swipeUp();
          },
          size: 35,
        ),
        buildActionButton(
          icon: FontAwesomeIcons.paperPlane,
          onTap: () {
            appinioSwiperController.swipeRight();
          },
        ),
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
