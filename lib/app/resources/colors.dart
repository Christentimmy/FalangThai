import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFFF9EE6);
  static const Color backgroundColor = Color(0xFF1A1625);
  static const Color cardColor = Color(0xFF2A2235);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8B8B8);

  // Sender (your messages)
  static const Color senderStart = Color(0xFFFF6B35);
  static const Color senderEnd = Color(0xFFF7931E);
  static const Color senderText = Colors.white;

  // Receiver (other person's messages)
  static const Color receiverBackground = Color(0xFFF1F3F4);
  static const Color receiverBorder = Color(0xFFE1E5E9);
  static const Color receiverText = Color(0xFF2C3E50);

  // Chat background
  static const Color chatBackground = Color(0xFFF8F9FA);

  // 🎯 NEW: Highlight colors for reply feature
  static const Color senderHighlightStart = Color(0xFFFF8A65);
  static const Color senderHighlightEnd = Color(0xFFFFB74D);
  static const Color senderHighlightShadow = Color(0x66FF8A65);

  static const Color receiverHighlightBackground = Color(0xFFFFF8E1);
  static const Color receiverHighlightBorder = Color(0xFFFFD54F);
  static const Color receiverHighlightShadow = Color(0x4DFFD54F);

  static Color lightGrey = const Color(0xFFF5F5F5);
}
