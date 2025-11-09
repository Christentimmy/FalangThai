import 'package:falangthai/app/controller/auth_controller.dart';
import 'package:falangthai/app/controller/invite_controller.dart';
import 'package:falangthai/app/controller/language_controller.dart';
import 'package:falangthai/app/controller/location_controller.dart';
import 'package:falangthai/app/controller/message_controller.dart';
import 'package:falangthai/app/controller/onesignal_controller.dart';
import 'package:falangthai/app/controller/socket_controller.dart';
import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/subscription_controller.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(StorageController());
    Get.put(UserController());
    Get.put(LocationController());
    Get.put(LanguageController());
    Get.put(OneSignalController());
    Get.put(MessageController());
    Get.put(SocketController());
    Get.put(SubscriptionController());
    Get.put(InviteController());
  }
}
