import 'package:flutter/material.dart';

extension ScreenSizeExtension on BuildContext {
  double screenWidth(double widthFactor) {
    return MediaQuery.of(this).size.width * widthFactor;
  }

  double screenHeight(double heightFactor) {
    return MediaQuery.of(this).size.height * heightFactor;
  }
}
