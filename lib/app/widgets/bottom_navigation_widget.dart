import 'package:falangthai/app/controller/socket_controller.dart';
import 'package:falangthai/app/modules/chat/views/chat_list_screen.dart';
import 'package:falangthai/app/modules/favorites/views/favorite_screen.dart';
import 'package:falangthai/app/modules/favorites/views/matches_screen.dart';
import 'package:falangthai/app/modules/home/views/home_screen.dart';
import 'package:falangthai/app/modules/settings/views/settings_screen.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final List<Widget> pages = [
    HomeScreen(),
    FavoriteScreen(),
    MatchesScreen(),
    ChatListScreen(),
    SettingsScreen(),
  ];

  final RxInt currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    final socketController = Get.find<SocketController>();
    if(socketController.socket == null || !socketController.socket!.connected) {
      socketController.initializeSocket();
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F0D15),
      body: Obx(() => pages[currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColors.primaryColor,
          backgroundColor: Color(0xFF0F0D15),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.thumb_up_alt), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
          currentIndex: currentIndex.value,
          onTap: (index) => currentIndex.value = index,
        ),
      ),
    );
  }
}
