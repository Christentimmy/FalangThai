import 'package:cached_network_image/cached_network_image.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/user_model.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/utils/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SwipeProfileScreen extends StatefulWidget {
  final String userId;
  const SwipeProfileScreen({super.key, required this.userId});

  @override
  State<SwipeProfileScreen> createState() => _SwipeProfileScreenState();
}

class _SwipeProfileScreenState extends State<SwipeProfileScreen> {
  final isloading = true.obs;
  final isBioExpanded = false.obs;
  Rxn<UserModel> userModel = Rxn<UserModel>();
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUserDetails();
    });
  }

  @override
  void dispose() {
    userModel.value = null;
    isloading.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1625),
      body: Container(
        height: Get.height,
        decoration: AuthWidgets().buildBackgroundDecoration(),
        child: Obx(() {
          if (isloading.value) {
            return buildLoader();
          }
          if (!isloading.value && userModel.value == null) {
            return buildNoData();
          }
          return buildContent();
        }),
      ),
    );
  }

  Center buildNoData() {
    return Center(
      child: Text(
        "No data found",
        style: GoogleFonts.figtree(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Center buildLoader() {
    return Center(
      child: CupertinoActivityIndicator(color: AppColors.primaryColor),
    );
  }

  SafeArea buildContent() {
    return SafeArea(
      child: Stack(children: [buildGallerySection(), buildUserDetails()]),
    );
  }

  Align buildUserDetails() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.56,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: bottomDecoration(),
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildBasicInfoSection(),
            const SizedBox(height: 20),
            _buildInterestsSection(),
            const SizedBox(height: 25),
            _buildPreferencesSection(),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  BoxDecoration bottomDecoration() {
    return BoxDecoration(
      color: Color(0xFF1A1625),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      border: Border(top: BorderSide(color: Color(0xFFD586D3), width: 1)),
    );
  }

  SizedBox buildGallerySection() {
    return SizedBox(
      height: Get.height * 0.45,
      width: Get.width,
      child: PageView.builder(
        itemCount: userModel.value?.photos?.length ?? 0,
        itemBuilder: (context, index) {
          final image = userModel.value?.photos?[index] ?? '';
          return CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return buildShimmerImageEffect();
            },
            errorWidget: (context, url, error) {
              return Icon(Icons.error, color: Colors.red);
            },
          );
        },
      ),
    );
  }

  Shimmer buildShimmerImageEffect() {
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
  }

  Widget _buildBasicInfoSection() {
    return _buildSection(
      title: "Basic Info",
      icon: Icons.person_4_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: GoogleFonts.fredoka(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            "${userModel.value?.fullName}",
            style: GoogleFonts.fredoka(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            "Age",
            style: GoogleFonts.fredoka(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            calculateAge(userModel.value?.dob),
            style: GoogleFonts.fredoka(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            "Gender",
            style: GoogleFonts.fredoka(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            userModel.value?.gender?.capitalizeFirst ?? '',
            style: GoogleFonts.fredoka(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            "Location",
            style: GoogleFonts.fredoka(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            userModel.value?.location?.address?.capitalizeFirst ?? '',
            style: GoogleFonts.fredoka(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),

          Text(
            "Bio",
            style: GoogleFonts.fredoka(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          Obx(() {
            if (isBioExpanded.value) {
              return Text(
                userModel.value?.bio?.capitalizeFirst ?? '',
                style: GoogleFonts.fredoka(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              );
            }
            final String safeBio = userModel.value?.bio?.capitalizeFirst ?? '';
            return Text(
              safeBio.length > 50 ? '${safeBio.substring(0, 50)}...' : safeBio,
              style: GoogleFonts.fredoka(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            );
          }),
          InkWell(
            onTap: () {
              isBioExpanded.value = !isBioExpanded.value;
            },
            child: Obx(() {
              return Text(
                isBioExpanded.value ? "Show Less" : "Show More",
                style: GoogleFonts.fredoka(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primaryColor,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return _buildSection(
      title: "Preferences",
      icon: Icons.tune_rounded,
      child: Column(
        children: [
          _buildPreferenceItem(
            title: "Age Range",
            value: userModel.value?.preferences?.ageRange?.join('-') ?? '',
            icon: Icons.cake_rounded,
          ),
          _buildPreferenceItem(
            title: "Distance",
            value: "${userModel.value?.preferences?.maxDistance?.toString()}Km",
            icon: Icons.location_on_rounded,
          ),
          _buildPreferenceItem(
            title: "Looking for",
            value: userModel.value?.interestedIn?.capitalizeFirst ?? '',
            icon: Icons.favorite_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF9EE6), size: 20),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.fredoka(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.fredoka(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsSection() {
    return _buildSection(
      title: "Interests",
      icon: Icons.interests_rounded,
      child: Obx(
        () => Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              userModel.value?.hobbies?.map((interest) {
                return _buildInterestChip(interest);
              }).toList() ??
              [],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFFF9EE6), size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.fredoka(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInterestChip(String interest) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9EE6).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFF9EE6).withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        interest,
        style: GoogleFonts.fredoka(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> getUserDetails() async {
    try {
      final user = await userController.getUserWithId(userId: widget.userId);
      if (user == null) return;
      userModel.value = user;
      userModel.value?.photos?.add(userModel.value?.avatar ?? '');
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
