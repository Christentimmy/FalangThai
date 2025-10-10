import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController
    with GetTickerProviderStateMixin {
      
  late AnimationController animationController;
  late Animation<double> bounceAnimation;

  final List<String> images = [
    "assets/images/pic1.jpeg",
    "assets/images/pic2.jpg",
    "assets/images/pic3.jpg",
    "assets/images/pic4.jpg",
    "assets/images/pic5.jpg",
    "assets/images/pic6.jpg",
    "assets/images/pic7.jpg",
    "assets/images/pic8.jpg",
    "assets/images/pic9.jpg",
    "assets/images/pic10.jpg",
    "assets/images/pic11.jpg",
    "assets/images/pic12.jpg",
    "assets/images/pic13.jpg",
    "assets/images/pic14.jpg",
    "assets/images/pic15.jpg",
    "assets/images/pic16.jpg",
    "assets/images/pic17.jpg",
    "assets/images/pic18.jpg",
    "assets/images/pic19.jpg",
    "assets/images/pic20.jpg",
    "assets/images/pic21.jpg",
  ];

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    bounceAnimation = Tween<double>(begin: -8.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
