import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );
  Widget paddingOnly({
    double leftValue = 0.0,
    double rightValue = 0.0,
    double topValue = 0.0,
    double bottomValue = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: leftValue,
          right: rightValue,
          top: topValue,
          bottom: bottomValue,
        ),
        child: this,
      );

  Widget marginAll(double value) => Container(
        margin: EdgeInsets.all(value),
        child: this,
      );
  Widget marginOnly({
    double leftValue = 0.0,
    double rightValue = 0.0,
    double topValue = 0.0,
    double bottomValue = 0.0,
  }) =>
      Container(
        margin: EdgeInsets.only(
          left: leftValue,
          right: rightValue,
          top: topValue,
          bottom: bottomValue,
        ),
        child: this,
      );
}
