import 'dart:io';

import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/utils/image_picker.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Profile Controller
class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadPhotos();
  }

  final userController = Get.find<UserController>();

  void loadPhotos() {
    final userModel = userController.userModel.value;
    if (userModel == null) return;
    ageRange.value = RangeValues(
      userModel.preferences?.ageRange?.first.toDouble() ?? 18.0,
      userModel.preferences?.ageRange?.last.toDouble() ?? 150.0,
    );
    maxDistance.value = userModel.preferences?.maxDistance?.toDouble() ?? 50.0;
    relationshipPreference.value =
        userModel.relationshipPreference ?? "Long-Term";
    interestedIn.value = userModel.interestedIn ?? "";
    if (userModel.photos?.isEmpty == true) return;
    photos.addAll(userModel.photos!);
  }

  // Observable States
  final RxBool isEditMode = false.obs;
  final RxMap<String, dynamic> profileData = <String, dynamic>{
    'name': 'Sarah Johnson',
    'bio': 'Love traveling, coffee, and meaningful conversations ✨',
    'age': 25,
  }.obs;

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  // Profile Image
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxList photos = [].obs;
  Rx<RangeValues> ageRange = RangeValues(18.0, 150.0).obs;
  RxDouble maxDistance = 50.0.obs;
  RxString relationshipPreference = "Long-Term".obs;
  RxString interestedIn = "".obs;

  // Interests
  final RxList<String> interests = <String>[
    'Travel',
    'Photography',
    'Coffee',
    'Reading',
    'Yoga',
    'Cooking',
    'Music',
    'Art',
  ].obs;

  Future<void> selectImage() async {
    if (photos.length > 6) {
      CustomSnackbar.showErrorToast("You can only add 6 photos");
      return;
    }
    final pickedFile = await pickImage();
    if (pickedFile == null) return;
    photos.add(pickedFile);
    await userController.addPhotoToGallery(imageFile: pickedFile);
  }

  Future<void> removePhoto(int index) async {
    photos.removeAt(index);
    await userController.removePhotoFromGallery(index: index);
  }

  Future<void> editProfile() async {
    await userController.editProfile(
      fullName: nameController.text,
      bio: bioController.text,
      relationshipPreference: relationshipPreference.value,
      interestedIn: interestedIn.value,
      ageRange: [ageRange.value.start.toInt(), ageRange.value.end.toInt()],
      maxDistance: maxDistance.value.toInt().toString(),
    );
    await userController.getUserDetails();
  }

  Future<void> updateProfileImage() async {
    final pickedFile = await pickImage();
    if (pickedFile == null) return;
    profileImage.value = pickedFile;
    await userController.updateProfileImage(imageFile: pickedFile);
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    profileImage.value = null;
    photos.clear();
    ageRange.value = RangeValues(18.0, 150.0);

    super.onClose();
  }
}
