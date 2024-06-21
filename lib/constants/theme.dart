import 'package:flutter/material.dart';
import 'package:flutter_challenge/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get appTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
        background: Colors.black,
        primary: AppColors.primary,
        secondary: AppColors.white),
    textTheme: GoogleFonts.publicSansTextTheme()
        .apply(bodyColor: AppColors.white, displayColor: AppColors.white));
