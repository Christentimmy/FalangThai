import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/routes/app_routes.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:falangthai/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

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
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: Get.height * 0.02),
                      buildReceiverCard(),
                      SizedBox(height: Get.height * 0.01),
                      buildSenderCard(),
                    ],
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
}
