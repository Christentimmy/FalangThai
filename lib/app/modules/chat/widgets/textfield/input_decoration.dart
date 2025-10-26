
import 'package:flutter/material.dart';

BoxDecoration chatInputFieldDecoration({bool? showBorderRadius = true}) {
  return BoxDecoration(
    // color: Colors.black,
    borderRadius: showBorderRadius == false ? null : BorderRadius.circular(30),
    border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
  );
}
