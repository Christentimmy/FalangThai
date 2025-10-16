import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/modules/profile/controllers/profile_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileController = Get.put(ProfileController());
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: SafeArea(child: _buildContent()),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF0F0D15),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
      ),
      title: Text(
        "Profile",
        style: GoogleFonts.fredoka(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            profileController.isEditMode.toggle();
            if (!profileController.isEditMode.value) {
              await profileController.editProfile();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9EE6).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFF9EE6).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Obx(
              () => Icon(
                profileController.isEditMode.value
                    ? Icons.check_rounded
                    : Icons.edit_rounded,
                color: const Color(0xFFFF9EE6),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0F0D15),
          Color(0xFF1F1B2E),
          Color(0xFF2D2438),
          Color(0xFF1A1625),
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        SizedBox(height: Get.height * 0.05),
        _buildProfileAvatar(),
        const SizedBox(height: 20),
        _buildProfileInfo(),
        const SizedBox(height: 30),
        _buildProfileSections(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      child: buildAvater(),
    );
  }

  Widget buildAvater() {
    return Obx(() {
      final userModel = userController.userModel.value;
      final profileImage = profileController.profileImage.value;
      final isEditMode = profileController.isEditMode.value;
      if (isEditMode || profileImage != null) {
        return Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: profileImage != null
                  ? FileImage(profileImage)
                  : CachedNetworkImageProvider(userModel?.avatar ?? ""),
            ),
            Positioned(
              bottom: 0,
              right: 5,
              child: InkWell(
                onTap: () async {
                  await profileController.updateProfileImage();
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFF9EE6).withValues(alpha: 0.2),
                    border: Border.all(
                      color: const Color(0xFFFF9EE6).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: const Color(0xFFFF9EE6),
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      }
      return InkWell(
        onTap: () {
          Get.dialog(Image.network(userModel?.avatar ?? ""));
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFFF9EE6).withValues(alpha: 0.6),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF9EE6).withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: CachedNetworkImage(
              imageUrl: userModel?.avatar ?? "",
              fit: BoxFit.cover,
              width: 115,
              height: 115,
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
              errorWidget: (context, url, error) {
                return Icon(Icons.error, color: Colors.red);
              },
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProfileInfo() {
    final userModel = userController.userModel.value;
    return Obx(
      () => Column(
        children: [
          profileController.isEditMode.value
              ? CustomTextField(
                  controller: profileController.nameController,
                  textAlign: TextAlign.center,
                  hintText: userModel?.fullName ?? "",
                  contentPadding: const EdgeInsets.only(
                    left: 40,
                    top: 10,
                    bottom: 10,
                  ),
                  hintStyle: GoogleFonts.fredoka(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                  ),
                )
              : Text(
                  userModel?.fullName ?? "",
                  style: GoogleFonts.fredoka(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          const SizedBox(height: 8),
          profileController.isEditMode.value
              ? CustomTextField(
                  controller: profileController.bioController,
                  textAlign: TextAlign.center,
                  hintText: userModel?.bio ?? "Tell us about yourself...",
                  maxLines: 3,
                  minLines: 2,
                  contentPadding: const EdgeInsets.only(
                    left: 40,
                    top: 10,
                    bottom: 10,
                  ),
                  hintStyle: GoogleFonts.fredoka(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                  ),
                )
              : Text(
                  userModel?.bio ?? "Tell us about yourself...",
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
        ],
      ),
    );
  }

  Widget _buildProfileSections() {
    return Column(
      children: [
        _buildInterestsSection(),
        const SizedBox(height: 25),
        _buildPhotosSection(),
        const SizedBox(height: 25),
        _buildPreferencesSection(),
      ],
    );
  }

  Widget buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(
          icon: Icons.favorite_rounded,
          value: "127",
          label: "Likes",
          color: const Color(0xFFEC4899),
        ),
        _buildStatItem(
          icon: Icons.visibility_rounded,
          value: "234",
          label: "Views",
          color: const Color(0xFF8B5CF6),
        ),
        _buildStatItem(
          icon: Icons.chat_bubble_rounded,
          value: "45",
          label: "Matches",
          color: const Color(0xFF06B6D4),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.fredoka(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.fredoka(
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsSection() {
    return InkWell(
      onTap: () {
        if (!profileController.isEditMode.value) return;
        Get.toNamed(AppRoutes.editHobbies);
      },
      child: _buildSection(
        title: "Interests",
        icon: Icons.interests_rounded,
        child: Obx(() {
          final userModel = userController.userModel.value;
          final interests = userModel!.hobbies!;
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: interests.map((interest) {
              return _buildInterestChip(interest);
            }).toList(),
          );
        }),
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
        interest.capitalizeFirst ?? "",
        style: GoogleFonts.fredoka(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPhotosSection() {
    return _buildSection(
      title: "Photos",
      icon: Icons.photo_library_rounded,
      child: SizedBox(
        height: 100,
        child: Obx(() {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: profileController.photos.length + 1,
            itemBuilder: (context, index) {
              final image = index == 0
                  ? null
                  : profileController.photos[index - 1];
              return _buildPhotoSlot(index, image);
            },
          );
        }),
      ),
    );
  }

  Widget _buildPhotoSlot(int index, dynamic image) {
    return InkWell(
      onTap: () {
        if (index != 0) {
          if (image is File) {
            Get.dialog(Image.file(image));
          } else if (image is String) {
            Get.dialog(Image.network(image));
          }
          return;
        }
        if (!profileController.isEditMode.value) return;
        profileController.selectImage();
      },
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 90,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
              image: index != 0 && image != null
                  ? buildEachPhoto(image: image)
                  : null,
            ),
            child: index == 0 || image == null
                ? Icon(
                    Icons.add_rounded,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 24,
                  )
                : null,
          ),
          Obx(() {
            if (profileController.isEditMode.value &&
                image != null &&
                index != 0) {
              return Positioned(
                top: 0,
                left: 0,
                child: InkWell(
                  onTap: () {
                    profileController.removePhoto(index - 1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                      size: 17,
                    ),
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  DecorationImage? buildEachPhoto({required dynamic image}) {
    if (image is File) {
      return DecorationImage(image: FileImage(image), fit: BoxFit.cover);
    }
    if (image is String) {
      return DecorationImage(image: NetworkImage(image), fit: BoxFit.cover);
    }
    return null;
  }

  Widget _buildPreferencesSection() {
    return _buildSection(
      title: "Preferences",
      icon: Icons.tune_rounded,
      child: Obx(() {
        final isEditMode = profileController.isEditMode.value;
        if (isEditMode) {
          return _buildPreferencesEditMode();
        }

        final userModel = userController.userModel.value;
        return Column(
          children: [
            _buildPreferenceItem(
              title: "Age Range",
              value: userModel?.preferences?.ageRange?.join("-") ?? "",
              icon: Icons.cake_rounded,
            ),
            _buildPreferenceItem(
              title: "Distance",
              value: "${userModel?.preferences?.maxDistance?.toString()} km",
              icon: Icons.location_on_rounded,
            ),
            _buildPreferenceItem(
              title: "Looking for",
              value: userModel?.relationshipPreference ?? "",
              icon: Icons.favorite_rounded,
            ),
            _buildPreferenceItem(
              title: "Interested In",
              value: profileController.interestedIn.value.capitalizeFirst ?? "",
              icon: Icons.favorite_rounded,
            ),
          ],
        );
      }),
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
              color: Colors.white.withValues(alpha: 0.8),
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

  Widget _buildPreferencesEditMode() {
    return Column(
      children: [
        _buildEditItemContainer(
          title: "Age Range",
          icon: Icons.cake_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${profileController.ageRange.value.start.toInt()} - ${profileController.ageRange.value.end.toInt()}",
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              RangeSlider(
                values: profileController.ageRange.value,
                min: 18,
                max: 150,
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.white.withValues(alpha: 0.3),
                onChanged: (RangeValues newValues) {
                  profileController.ageRange.value = newValues;
                },
              ),
            ],
          ),
        ),

        _buildEditItemContainer(
          title: "Max Distance",
          icon: Icons.location_on_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${profileController.maxDistance.value.toInt()} km",
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              Slider(
                value: profileController.maxDistance.value,
                max: 200,
                divisions: 39,
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.white.withValues(alpha: 0.3),
                onChanged: (double newValue) {
                  profileController.maxDistance.value = newValue;
                },
              ),
            ],
          ),
        ),

        _buildEditItemContainer(
          title: "Looking for",
          icon: Icons.favorite_rounded,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              value: profileController.relationshipPreference.value,
              dropdownColor: Colors.black.withValues(alpha: 0.8),
              style: GoogleFonts.fredoka(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              items: const [
                DropdownMenuItem(value: "Marriage", child: Text("Marriage")),
                DropdownMenuItem(value: "Friends", child: Text("Friends")),
                DropdownMenuItem(
                  value: "Short-Term",
                  child: Text("Short-Term"),
                ),
                DropdownMenuItem(value: "Long-Term", child: Text("Long-Term")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (String? newValue) {
                profileController.relationshipPreference.value = newValue!;
              },
            ),
          ),
        ),

        _buildEditItemContainer(
          title: "Interested In",
          icon: Icons.favorite_rounded,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              value: profileController.interestedIn.value.toLowerCase(),
              dropdownColor: Colors.black.withValues(alpha: 0.8),
              style: GoogleFonts.fredoka(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              items: const [
                DropdownMenuItem(value: "men", child: Text("Men")),
                DropdownMenuItem(value: "women", child: Text("Women")),
                DropdownMenuItem(
                  value: "non-binary",
                  child: Text("Non-Binary"),
                ),
                DropdownMenuItem(
                  value: "transgender",
                  child: Text("Transgender"),
                ),
                DropdownMenuItem(value: "everyone", child: Text("Everyone")),
              ],
              onChanged: (String? newValue) {
                profileController.interestedIn.value = newValue!;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditItemContainer({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.fredoka(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: child, // Insert the interactive widget here
          ),
        ],
      ),
    );
  }
}
