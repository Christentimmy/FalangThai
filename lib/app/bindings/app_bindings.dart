

import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(StorageController());
  }
}