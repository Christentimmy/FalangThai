import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:falangthai/app/utils/base_url.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService {
  http.Client client = http.Client();

  Future<http.Response?> getUserDetails({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-user-details"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateGender({
    required String token,
    required String gender,
  }) async {
    try {
      final response = await client
          .patch(
            Uri.parse("$baseUrl/user/update-gender"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'gender': gender}),
          )
          .timeout(const Duration(seconds: 10));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateLocation({
    required String token,
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    try {
      final response = await client
          .patch(
            Uri.parse("$baseUrl/user/update-location"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'latitude': latitude,
              'longitude': longitude,
              "address": address,
            }),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateHobbies({
    required String token,
    required List<String> hobbies,
  }) async {
    try {
      final response = await client
          .patch(
            Uri.parse("$baseUrl/user/update-hobbies"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'hobbies': hobbies}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateInterestedIn({
    required String token,
    required String interestedIn,
  }) async {
    try {
      final response = await client
          .patch(
            Uri.parse("$baseUrl/user/update-interest-in"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'interest_in': interestedIn}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> saveUserOneSignalId({
    required String token,
    required String id,
  }) async {
    try {
      final response = await client
          .patch(
            Uri.parse("$baseUrl/user/update-one-signal-id/$id"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getPotentialMatches({
    required String token,
    int? page,
  }) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-potential-matches?page=$page"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getUserWithId({
    required String token,
    required String userId,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/user/get-user-with-id/$userId');
      final response = await client
          .get(url, headers: {'Authorization': 'Bearer $token'})
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> swipeLike({
    required String token,
    required String targetUserId,
    required String type,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/swipe-user"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'targetUserId': targetUserId, 'type': type}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getUserWhoLikesMe({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-users-who-liked-me"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getMatches({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-matches"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> addPhotoToGallery({
    required String token,
    required File imageFile,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/user/add-photo-to-gallery");

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..files.add(
          await http.MultipartFile.fromPath('photos', imageFile.path),
        );

      var response = await request.send().timeout(const Duration(seconds: 20));
      return await http.Response.fromStream(response);
    } on SocketException catch (e) {
      CustomSnackbar.showErrorToast("Check internet connection, $e");
      debugPrint("No internet connection");
      return null;
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> removePhotoFromGallery({
    required String token,
    required int index,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/remove-photo-from-gallery"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'index': index}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> editProfile({
    String? fullName,
    String? bio,
    String? relationshipPreference,
    String? interestedIn,
    List? ageRange,
    String? maxDistance,
    required String token,
  }) async {
    try {
      Map<String, dynamic> body = {};
      if (fullName != null) {
        body['full_name'] = fullName;
      }
      if (bio != null) {
        body['bio'] = bio;
      }
      if (relationshipPreference != null) {
        body['relationship_preference'] = relationshipPreference;
      }
      if (interestedIn != null) {
        body['interested_in'] = interestedIn;
      }
      if (ageRange != null) {
        body['age_range'] = ageRange;
      }
      if (maxDistance != null) {
        body['max_distance'] = maxDistance;
      }

      final response = await client
          .patch(
            Uri.parse("$baseUrl/user/edit-profile"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateProfileImage({
    required String token,
    required File imageFile,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/user/update-profile-image");

      var request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..files.add(
          await http.MultipartFile.fromPath('avatar', imageFile.path),
        );

      var response = await request.send().timeout(const Duration(seconds: 20));
      return await http.Response.fromStream(response);
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> createTicket({
    required String token,
    required List<File> attachments,
    required String subject,
    required String description,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/support/create-ticket");
      final requests = http.MultipartRequest("POST", url)
        ..headers['Authorization'] = 'Bearer $token';
      final files = await Future.wait(
        attachments
            .map((e) => http.MultipartFile.fromPath('attachments', e.path))
            .toList(),
      );
      requests.files.addAll(files);
      requests.fields['subject'] = subject;
      requests.fields['description'] = description;
      final response = await requests.send().timeout(
        const Duration(seconds: 60),
      );
      return await http.Response.fromStream(response);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getNotification({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-user-notifications"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> markNotificationAsRead({
    required String token,
    required List<String> ids,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/user/mark-notifications-read"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"notificationIds": ids}),
      );
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
