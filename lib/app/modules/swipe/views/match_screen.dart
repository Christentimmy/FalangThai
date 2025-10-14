import 'package:cached_network_image/cached_network_image.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class MatchScreen extends StatefulWidget {
  final String targetUserId;
  const MatchScreen({super.key, required this.targetUserId});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final userController = Get.find<UserController>();
  Rxn<UserModel> targetUser = Rxn<UserModel>();
  final isloading = true.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getTargetUser();
    });
  }

  @override
  void dispose() {
    targetUser.value = null;
    super.dispose();
  }

  Future<void> getTargetUser() async {
    try {
      final userId = widget.targetUserId;
      if (userId.isEmpty) return;
      final targetUser = await userController.getUserWithId(userId: userId);
      if (targetUser == null) return;
      this.targetUser.value = targetUser;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1625),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: AuthWidgets().buildBackgroundDecoration(),
        child: SafeArea(
          child: Obx(() {
            if (isloading.value) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }
            return buildContent();
          }),
        ),
      ),
    );
  }

  Padding buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              // const Spacer(),
              // InkWell(
              //   onTap: () => Get.toNamed(AppRoutes.addPictures),
              //   child: Text(
              //     "Skip",
              //     style: GoogleFonts.figtree(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600,
              //       color: AppColors.primaryColor,
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: Get.height * 0.02),
          Center(
            child: Text(
              "Congratulations\nYou have a match!",
              textAlign: TextAlign.center,
              style: GoogleFonts.figtree(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.05),
          Center(
            child: SizedBox(
              height: Get.height * 0.4,
              width: Get.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: 0.25,
                    child: Container(
                      height: Get.height * 0.34,
                      width: Get.width * 0.42,
                      margin: EdgeInsets.only(
                        left: Get.width * 0.15,
                        bottom: Get.height * 0.1,
                      ),
                      child: buildImage(
                        imageUrl: targetUser.value?.avatar ?? "",
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -0.2,
                    child: Container(
                      height: Get.height * 0.34,
                      width: Get.width * 0.42,
                      margin: EdgeInsets.only(
                        top: Get.height * 0.07,
                        right: Get.width * 0.2,
                      ),
                      child: buildImage(
                        imageUrl: userController.userModel.value?.avatar ?? "",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          CustomButton(
            ontap: () {
              userController.getPotentialMatches();
              Get.offNamed(AppRoutes.message);
            },
            isLoading: false.obs,
            child: Text(
              "Send a text",
              style: GoogleFonts.figtree(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomButton(
            ontap: () {
              userController.getPotentialMatches();
              Get.back();
            },
            bgColor: Color(0xFF1A1625),
            isLoading: false.obs,
            child: Text(
              "Keep swiping",
              style: GoogleFonts.figtree(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.05),
        ],
      ),
    );
  }

  ClipRRect buildImage({required String imageUrl}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
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
    );
  }
}
