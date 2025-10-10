import 'package:falangthai/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: SafeArea(
          child: Stack(children: [_buildContent(), _buildHeader()]),
        ),
      ),
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

  Widget _buildHeader() {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const Spacer(),
            Text(
              "Profile",
              style: GoogleFonts.fredoka(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            GestureDetector(
              // onTap: () => profileController.toggleEditMode(),
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
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          SizedBox(height: Get.height * 0.12),
          _buildProfileAvatar(),
          const SizedBox(height: 20),
          _buildProfileInfo(),
          const SizedBox(height: 30),
          Expanded(child: _buildProfileSections()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Obx(
      () => GestureDetector(
        onTap: profileController.isEditMode.value ? () {} : null,
        child: Container(
          width: 120,
          height: 120,
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
          child: Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profileController.profileImage.value != null
                      ? FileImage(profileController.profileImage.value!)
                      : null,
                  child: profileController.profileImage.value == null
                      ? const Icon(
                          Icons.person_rounded,
                          size: 50,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Obx(
      () => Column(
        children: [
          profileController.isEditMode.value
              ? _buildEditableTextField(
                  controller: profileController.nameController,
                  style: GoogleFonts.fredoka(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                )
              : Text(
                  "Your Name",
                  style: GoogleFonts.fredoka(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          const SizedBox(height: 8),
          profileController.isEditMode.value
              ? _buildEditableTextField(
                  controller: profileController.bioController,
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                )
              : Text(
                  "Tell us about yourself...",
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

  Widget _buildEditableTextField({
    required TextEditingController controller,
    required TextStyle style,
    TextAlign textAlign = TextAlign.start,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintStyle: style.copyWith(color: Colors.white.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildProfileSections() {
    return Column(
      children: [
        _buildStatsRow(),
        const SizedBox(height: 30),
        _buildInterestsSection(),
        const SizedBox(height: 25),
        _buildPhotosSection(),
        const SizedBox(height: 25),
        _buildPreferencesSection(),
      ],
    );
  }

  Widget _buildStatsRow() {
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
    return _buildSection(
      title: "Interests",
      icon: Icons.interests_rounded,
      child: Obx(
        () => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: profileController.interests.map((interest) {
            return _buildInterestChip(interest);
          }).toList(),
        ),
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

  Widget _buildPhotosSection() {
    return _buildSection(
      title: "Photos",
      icon: Icons.photo_library_rounded,
      child: Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return _buildPhotoSlot(index);
          },
        ),
      ),
    );
  }

  Widget _buildPhotoSlot(int index) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Icon(
        index == 0 ? Icons.add_rounded : Icons.photo_rounded,
        color: Colors.white.withOpacity(0.6),
        size: 24,
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
            value: "22-28",
            icon: Icons.cake_rounded,
          ),
          _buildPreferenceItem(
            title: "Distance",
            value: "Within 25 km",
            icon: Icons.location_on_rounded,
          ),
          _buildPreferenceItem(
            title: "Looking for",
            value: "Long-term relationship",
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
}
