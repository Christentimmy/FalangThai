import 'package:falangthai/app/controller/storage_controller.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initOneSignal();
  }

  void initOneSignal() async {
    OneSignal.initialize("2fa250e8-3569-45a5-9c27-db2be9b84c36");
    final isPermissionEnabled = OneSignal.Notifications.permission;
    if (!isPermissionEnabled) {
      OneSignal.Notifications.requestPermission(true);
    }

    final storageController = Get.find<StorageController>();
    bool isSaved = await storageController.isSignalSaveOnThisDevice();
    if (isSaved) return;
    final playerId = OneSignal.User.pushSubscription.id ?? "";
    if (playerId.isEmpty) return;

    final userController = Get.find<UserController>();
    await userController.saveUserOneSignalId(id: playerId);
    await storageController.saveSignalSaveOnThisDevice(true);
  }
}
