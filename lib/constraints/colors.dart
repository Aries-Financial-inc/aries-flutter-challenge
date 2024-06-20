
import 'package:flutter/material.dart';

class AppColors {
  static const Color egoPrimaryColor = Color(0xffe68823);
  static const Color egoBackgroundColor = Color(0xff0E1117);
  static const Color egoAccentColor = Color(0xff161b22);

  static InputDecorationTheme egoInputDecorationTheme = InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffe68823)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        // borderSide: const BorderSide(color: Color(0xffe68823)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffe68823)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      focusColor: const Color(0xffe68823),
      hintStyle: const TextStyle(color: Colors.white));
}
