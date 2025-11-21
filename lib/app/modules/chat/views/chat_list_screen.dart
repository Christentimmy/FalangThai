import 'package:falangthai/app/controller/message_controller.dart';
import 'package:falangthai/app/data/models/chat_list_model.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final _messageController = Get.find<MessageController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_messageController.isChattedListFetched.value) {
        _messageController.getChatList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          decoration: AuthWidgets().buildBackgroundDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                // _buildStory(),
                SizedBox(height: Get.height * 0.01),
                Obx(() {
                  if (_messageController.isChatListLoading.value) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return _buildChatItemSkeleton(true);
                      },
                    );
                  }

                  if (_messageController.allChattedUserList.isEmpty) {
                    return _buildEmptyList(true);
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _messageController.allChattedUserList.length,
                    itemBuilder: (context, index) {
                      final chatHead =
                          _messageController.allChattedUserList[index];
                      return buildChatTile(chatHead: chatHead);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyList(bool isDark) {
    final text = AppLocalizations.of(Get.context!)!;
    return SizedBox(
      height: Get.height * 0.65,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text.noConversationsYet,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text.startChattingWithYourMatches,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItemSkeleton(bool isDark) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(199, 15, 13, 21),
      highlightColor: AppColors.primaryColor,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(199, 15, 13, 21),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          title: Container(
            width: 100,
            height: 16,
            color: Color.fromARGB(199, 15, 13, 21),
            margin: const EdgeInsets.only(bottom: 8),
          ),
          subtitle: Container(
            width: 150,
            height: 14,
            color: Color.fromARGB(199, 15, 13, 21),
          ),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color.fromARGB(199, 15, 13, 21),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF1A1625),
      title: Text(
        AppLocalizations.of(context)!.chatsTitle,
        style: GoogleFonts.figtree(
          fontSize: 25,
          fontWeight: FontWeight.w800,
          color: Get.theme.primaryColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: AppColors.primaryColor),
        ),
      ],
    );
  }

  ListTile buildChatTile({required ChatListModel chatHead}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 5,
      onTap: () {
        Get.toNamed(AppRoutes.message, arguments: {"chatHead": chatHead});
      },
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage(chatHead.avatar ?? ""),
      ),
      title: Text(
        chatHead.fullName ?? "",
        style: GoogleFonts.fredoka(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        chatHead.lastMessage ?? "",
        style: GoogleFonts.fredoka(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
      trailing: chatHead.unreadCount == 0 ? const SizedBox() : CircleAvatar(
        radius: 13,
        backgroundColor: AppColors.primaryColor,
        child: Text(
          chatHead.unreadCount.toString(),
          style: GoogleFonts.figtree(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildStory() {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      height: Get.height * 0.088,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Get.toNamed(AppRoutes.viewStory);
            },
            child: Stack(
              children: [
                Container(
                  width: Get.width * 0.18,
                  height: Get.height * 0.085,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      "assets/images/pic6.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                index == 0
                    ? Positioned(
                        right: 5,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            // Get.toNamed(AppRoutes.createPost);
                          },
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
