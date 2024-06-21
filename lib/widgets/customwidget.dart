import 'package:flutter/material.dart';

import '../linker.dart';
// import 'package:nb_utils/nb_utils.dart';

class CustomWidget {
  static Text text7(String data,
      {Key? key, TextStyle? style, Color? color, double? fontSize}) {
    return Text(data,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ));
  }

  /// Semi-bold
  static Text text6(
    String data, {
    Key? key,
    TextStyle? style,
    Color? color,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(data,
        overflow: overflow,
        maxLines: maxLines,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ));
  }

  /// Normal / regular / plain
  static Text text4(
    String data, {
    Key? key,
    TextStyle? style,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
  }) {
    return Text(data,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          decoration: decoration,
        ));
  }

  /// Light
  static Text text3(
    String data, {
    Key? key,
    TextStyle? style,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(data,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
        ));
  }

  /// Medium
  static Text text5(
    String data, {
    Key? key,
    TextStyle? style,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(data,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ));
  }
}
