import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<File?> pickImage({ImageSource? imageSource}) async {
  final pickedFile = await ImagePicker().pickImage(
    source: imageSource ?? ImageSource.gallery,
    imageQuality: 50,
  );
  if (pickedFile != null) {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(
      dir.path,
      "${DateTime.now().millisecondsSinceEpoch}_${path.basename(pickedFile.path)}",
    );

    // Compress further
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      pickedFile.path,
      targetPath,
      quality: 50,
    );

    if (compressedFile != null) {
      return File(compressedFile.path);
    }
  }
  return null;
}

Future<File?> pickMedia() async {
  final pickedFile = await ImagePicker().pickMedia(imageQuality: 50);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<List<File>?> pickMultipleImages() async {
  try {
    final picker = ImagePicker();
    List<XFile> pickedFiles = await picker.pickMultiImage(limit: 10);

    if (pickedFiles.isNotEmpty) {
      List<File> compressedFiles = [];

      for (var file in pickedFiles) {
        final dir = await getTemporaryDirectory();
        final targetPath = path.join(
          dir.path,
          "${DateTime.now().millisecondsSinceEpoch}.jpg",
        );

        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          file.path,
          targetPath,
          quality: 65,
        );

        if (compressedFile != null) {
          compressedFiles.add(File(compressedFile.path));
        }
      }

      return compressedFiles;
    }
    return null;
  } catch (e) {
    print('Error picking multiple images: $e');
    return null;
  }
}

Future<File?> pickVideo() async {
  final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

  if (pickedFile != null) {
    final compressedVideo = await VideoCompress.compressVideo(
      pickedFile.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );

    return compressedVideo?.file;
  }

  return null;
}

Future<List<File>?> pickFile() async {
  try {
    final ImagePicker imagePicker = ImagePicker();
    List<XFile?>? file = await imagePicker.pickMultipleMedia(
      limit: 5,
      imageQuality: 50,
    );
    if (file.isNotEmpty) {
      return file.map((e) => File(e!.path)).toList();
    }
    return null;
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}
