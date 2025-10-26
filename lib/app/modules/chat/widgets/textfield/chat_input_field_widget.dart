import 'package:falangthai/app/data/models/chat_list_model.dart';
import 'package:falangthai/app/modules/chat/controller/chat_controller.dart';
import 'package:falangthai/app/modules/chat/widgets/media/media_picker_bottom_sheet.dart';
import 'package:falangthai/app/modules/chat/widgets/shared/reply_to_content_widget.dart';
import 'package:falangthai/app/modules/chat/widgets/textfield/audio_input_widget.dart';
import 'package:falangthai/app/modules/chat/widgets/textfield/input_decoration.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewChatInputFields extends StatelessWidget {
  final ChatController controller;
  final ChatListModel chatHead;

  NewChatInputFields({
    super.key,
    required this.controller,
    required this.chatHead,
  });

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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isRecording = controller.audioController.isRecording.value;
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isRecording
            ? AudioInputPreview(controller: controller)
            // : buildTextField(),
            : buildInputFieldRow(context),
      );
    });
  }

  Widget buildInputFieldRow(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(2.5),
                decoration: chatInputFieldDecoration(),
                child: Column(
                  children: [
                    ReplyToContent(
                      controller: controller,
                      chatHead: chatHead,
                      isSender: false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 13),
                        Expanded(
                          child: TextField(
                            minLines: 1,
                            maxLines: 3,
                            onTap: () {
                              controller.showEmojiPicker.value = false;
                              FocusManager.instance.primaryFocus?.requestFocus();
                            },
                            cursorColor: AppColors.primaryColor,
                            controller: controller.textMessageController,
                            onChanged: controller.handleTyping,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade300,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.attach_file_rounded,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () => _showMediaPickerBottomSheet(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              final hasTextOrMedia =
                  controller.wordsTyped.value.isNotEmpty ||
                  controller.mediaController.selectedFile.value != null ||
                  controller.audioController.selectedFile.value != null ||
                  controller.mediaController.multipleMediaSelected.isNotEmpty;

              return Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primaryColor,
                  child: IconButton(
                    icon: Icon(
                      hasTextOrMedia ? Icons.send : Icons.mic,
                      color: Colors.white,
                      size: hasTextOrMedia ? 18 : null,
                    ),
                    onPressed: hasTextOrMedia
                        ? controller.sendMessage
                        : controller.audioController.startRecording,
                  ),
                ),
              );
            }),
          ],
        ),
        // SizedBox(height: 5),
        // Emoji picker
        // _buildEmojiPicker(),
      ],
    );
  }

  Widget buildTextField() {
    return Column(
      children: [
        Row(
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
        ),
      ],
    );
  }

  Obx buildEmojiPicker() {
    return Obx(
      () => controller.showEmojiPicker.value
          ? SizedBox(
              height: Get.height * 0.35,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  final text = controller.textMessageController.text;
                  final selection = controller.textMessageController.selection;
                  final newText = text.replaceRange(
                    selection.start,
                    selection.end,
                    emoji.emoji,
                  );
                  controller.textMessageController.value = TextEditingValue(
                    text: newText,
                    selection: TextSelection.collapsed(
                      offset: selection.start + emoji.emoji.length,
                    ),
                  );
                },
                // config: Config(
                //   bottomActionBarConfig: BottomActionBarConfig(
                //     backgroundColor: Get.theme.colorScheme.surface,
                //     buttonColor: Get.theme.scaffoldBackgroundColor,
                //   ),
                // ),
              ),
            )
          : const SizedBox(),
    );
  }

  void _showMediaPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) => MediaPickerBottomSheet(controller: controller),
    );
  }
}
