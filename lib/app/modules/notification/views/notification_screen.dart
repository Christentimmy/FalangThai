import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/notification_model.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final userController = Get.find<UserController>();
  RxList<String> notificationIds = <String>[].obs;

  @override
  void initState() {
    super.initState();
    notificationIds.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.notificationList.isEmpty) {
        userController.getNotifications();
      }
    });
  }

  @override
  void dispose() {
    userController.markNotificationAsRead(ids: notificationIds);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar(),
      body: Obx(() {
        if (userController.isloading.value) {
          return Center(
            child: CupertinoActivityIndicator(color: AppColors.primaryColor),
          );
        }
        if (userController.notificationList.isEmpty) {
          return Center(
            child: Text(
              "No notifications",
              style: GoogleFonts.fredoka(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => userController.getNotifications(showLoader: false),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: userController.notificationList.length,
            itemBuilder: (context, index) {
              final notification = userController.notificationList[index];
              return buildSystemCard(notification: notification);
            },
          ),
        );
      }),
    );
  }

  Widget buildSystemCard({required NotificationModel notification}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Obx(() {
        return ListTile(
          onTap: () {
            notification.isRead.value = true;
            if (notificationIds.contains(notification.id)) {
              return;
            }
            notificationIds.add(notification.id);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          horizontalTitleGap: 10,
          tileColor: !notification.isRead.value
              ? AppColors.primaryColor.withValues(alpha: 0.2)
              : Colors.transparent,
          leading: CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFF542C13),
            child: Text(
              notification.type[0].toUpperCase(),
              style: GoogleFonts.fredoka(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            notification.message,
            style: GoogleFonts.fredoka(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            DateFormat("hh:mm a | dd MMM yyyy").format(notification.createdAt),
            style: GoogleFonts.fredoka(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          // trailing: Icon(Icons.verified, color: Colors.blue),
        );
      }),
    );
  }

  ListTile buildTextCard() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 10,
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage("assets/images/pic5.jpg"),
      ),
      title: Text(
        "Jessica sent you a text",
        style: GoogleFonts.figtree(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        "2 hours ago",
        style: GoogleFonts.figtree(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(Icons.message, color: Get.theme.primaryColor),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios_new),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF1A1625),
      title: Text(
        "Notifications",
        style: GoogleFonts.figtree(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
