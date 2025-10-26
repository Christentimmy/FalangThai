import 'dart:ui';

import 'package:falangthai/app/data/models/chat_list_model.dart';
import 'package:falangthai/app/data/models/message_model.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/modules/chat/controller/chat_controller.dart';
import 'package:falangthai/app/modules/chat/widgets/receiver_card.dart';
import 'package:falangthai/app/modules/chat/widgets/sender_card.dart';
import 'package:falangthai/app/modules/chat/widgets/shimmer/chat_loader_shimmer.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessageScreen extends StatefulWidget {
  final ChatListModel chatHead;
  const MessageScreen({super.key, required this.chatHead});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List giftList = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
    "assets/images/7.png",
    "assets/images/8.png",
  ];

  late final ChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = Get.put(ChatController(), tag: widget.chatHead.userId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatController.initialize(widget.chatHead);
    });
  }

  @override
  void dispose() {
    Get.delete<ChatController>(tag: widget.chatHead.userId);
    _chatController.closeScreen();
    super.dispose();
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                // Expanded(
                //   child: ListView(
                //     children: [
                // SizedBox(height: Get.height * 0.02),
                // buildReceiverCard(),
                // SizedBox(height: Get.height * 0.01),
                // buildSenderCard(),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Stack(
                    children: [_buildMessageList(), _buildScrollDownButton()],
                  ),
                ),
                buildTextField(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollDownButton() {
    return Obx(() {
      final shouldShow =
          _chatController.showScrollToBottomButton.value &&
          _chatController.isVisible.value;

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        bottom: shouldShow ? 20 : -100,
        right: 20,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          opacity: shouldShow ? 1.0 : 0.0,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            scale: shouldShow ? 1.0 : 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        HapticFeedback.selectionClick();
                        _chatController.scrollToBottom();
                      },
                      child: const Icon(
                        Icons.expand_more_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Row buildTextField() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            hintText: "Type something...",
            suffixIcon: Icons.add,
            prefixIcon: Icons.card_giftcard_rounded,
            prefixIconColor: Colors.grey,
            onPrefixTap: () {
              Get.bottomSheet(
                Container(
                  height: Get.height * 0.35,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1F1B2E),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: GridView.builder(
                          itemCount: giftList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Image.asset(
                                  giftList[index],
                                  width: 50,
                                  height: 50,
                                ),
                                // SizedBox(height: 5),
                                Text(
                                  "${index + 20} peeks",
                                  style: GoogleFonts.fredoka(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "300 peeks",
                              style: GoogleFonts.fredoka(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            CustomButton(
                              ontap: () {},
                              isLoading: false.obs,
                              width: Get.width * 0.25,
                              height: 35,
                              child: Text(
                                "Send",
                                style: GoogleFonts.fredoka(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
              );
            },
            hintStyle: GoogleFonts.fredoka(fontSize: 14, color: Colors.grey),
          ),
        ),
        SizedBox(width: 5),
        CircleAvatar(
          radius: 23,
          backgroundColor: AppColors.primaryColor,
          child: Transform.rotate(
            angle: -0.4,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.send, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF1A1625),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/pic12.jpg"),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jessica Baker",
                    style: GoogleFonts.figtree(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  Text(
                    "Active now",
                    style: GoogleFonts.figtree(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.videoCall),
          icon: Icon(Icons.video_call, color: Colors.white),
        ),
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.audioCall),
          icon: Icon(Icons.call, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, color: Colors.white),
        ),
      ],
    );
  }

  Align buildReceiverCard() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width * 0.7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/pic15.jpg"),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 231, 216, 228),
                    ),
                    child: Text(
                      "Nice! I’m always looking for new spots. What’s the name?",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.figtree(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      "22:50",
                      style: GoogleFonts.figtree(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align buildSenderCard() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.primaryColor,
              ),
              child: Text(
                "It’s called Pine Ridge, gorgeous views and a waterfall at the end. Totally worth the climb.",
                softWrap: true,
                overflow: TextOverflow.visible,
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                "22:50",
                style: GoogleFonts.figtree(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return Obx(() {
      final messageController = _chatController.messageController;
      final savedChatToAvoidLoading = messageController.savedChatToAvoidLoading;
      List<MessageModel> oldChats =
          savedChatToAvoidLoading[widget.chatHead.userId] ?? [];
      final chatHistoryAndLiveMessage =
          messageController.chatHistoryAndLiveMessage;
      if (oldChats.isEmpty && messageController.isloading.value) {
        return const ChatShimmerEffect(
          itemCount: 20,
          showSenderCards: true,
          showReceiverCards: true,
          // showImageCards: true,
          // showAudioCards: true,
        );
      }

      if (oldChats.isNotEmpty && messageController.isloading.value) {
        return _buildMessageListView(oldChats);
      }

      if (chatHistoryAndLiveMessage.isEmpty && oldChats.isEmpty) {
        return const Center(child: Text("No Message"));
      }

      return _buildMessageListView(chatHistoryAndLiveMessage);
    });
  }

  Widget _buildMessageListView(List<MessageModel> messages) {
    return ScrollablePositionedList.builder(
      key: PageStorageKey<String>('chat_list_${widget.chatHead.userId}'),
      itemScrollController: _chatController.scrollController,
      itemPositionsListener: _chatController.itemPositionsListener,
      itemCount: messages.length,
      reverse: true,
      // cacheExtent: 1000,
      physics: const AlwaysScrollableScrollPhysics(),
      addRepaintBoundaries: true,
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) {
        final reversedIndex = messages.length - 1 - index;
        final message = messages[reversedIndex];
        final isSender =
            message.senderId ==
            _chatController.userController.userModel.value!.id;
        final bubble = isSender
            ? RepaintBoundary(
                child: SenderCard(
                  messageModel: message,
                  chatHead: widget.chatHead,
                ),
              )
            : RepaintBoundary(
                child: ReceiverCard(
                  messageModel: message,
                  chatController: _chatController,
                  chatHead: widget.chatHead,
                ),
              );
        if (index == 0) {
          return TweenAnimationBuilder<Offset>(
            key: ValueKey(
              message.id ?? message.createdAt?.toIso8601String() ?? index,
            ),
            tween: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            builder: (context, offset, child) {
              return Transform.translate(
                offset: Offset(0, offset.dy * 50),
                child: child,
              );
            },
            child: bubble,
          );
        } else {
          return bubble;
        }
      },
    );
  }
}
