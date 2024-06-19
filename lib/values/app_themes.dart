// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightThemeData(Brightness brightness) {
    var colorScheme = ColorScheme(
      brightness: brightness,
      primary: const Color(0xff6002ee),
      onPrimary: const Color(0xffffffff),
      secondary: const Color(0xff6002ee),
      onSecondary: const Color(0xffffffff),
      error: const Color(0xffb00020),
      onError: const Color(0xffffffff),
      background: const Color(0xffffffff),
      onBackground: const Color(0xff000000),
      surface: const Color(0xffffffff),
      onSurface: const Color(0xff000000),
    );

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      primarySwatch: const MaterialColor(0xff6002ee, {
        50: Color(0Xffefe5fd),
        100: Color(0xffd4bff9),
        200: Color(0xffb794f6),
        300: Color(0xff9965f4),
        400: Color(0xff7e3ff2),
        500: Color(0xff6002ee),
        600: Color(0xff5300e8),
        700: Color(0xff3d00e0),
        800: Color(0xff1c00db),
        900: Color(0xff0000d6)
      }),
      iconTheme: IconThemeData(color: colorScheme.primary),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.withOpacity(0.1),
        selectedColor: colorScheme.primary.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        // labelStyle: GoogleFonts.notoSans(
        //   fontWeight: FontWeight.normal,
        //   fontSize: AppDimens.mediumFontSize,
        //   color: colorScheme.onSurface,
        // ),
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        isDense: true,
        floatingLabelStyle: TextStyle(color: colorScheme.primary),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.surface,
          side: BorderSide(color: colorScheme.primary),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme.primary,
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary.withOpacity(0.7),
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          // fontSize: AppDimens.mediumFontSize,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          // fontSize: AppDimens.mediumFontSize,
        ),
        selectedItemColor: colorScheme.onPrimary,
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.7),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.primary,
        dense: true,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.onBackground.withOpacity(0.3),
        space: 0,
      ),
    );
  }
}
