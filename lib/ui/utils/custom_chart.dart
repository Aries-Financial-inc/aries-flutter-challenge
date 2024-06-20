import 'package:flutter/material.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: CustomPaint(
        size: Size.infinite,
        painter: StockVolumePainter(),
      ),
    );
  }
}

class StockVolumePainter extends CustomPainter {
  // final StockTime
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class Bar {
  final double width, height, centerX;
  final Paint paint;
  const Bar({
    required this.width,
    required this.height,
    required this.centerX,
    required this.paint,
  });
}
