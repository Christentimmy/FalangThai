import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  RxnString locale = RxnString();

  @override
  void onInit() {
    super.onInit();
    getSelectLanguage();
  }

  Future<void> getSelectLanguage() async {
    final String? value = await _secureStorage.read(key: "language");
    if (value == null) return;
    locale.value = value;
    Get.updateLocale(Locale(value));
  }

  Future<void> saveLanguage(String value) async {
    await _secureStorage.write(key: "language", value: value);
    locale.value = value;
    Get.updateLocale(Locale(value));
  }
}
