import 'package:flutter/material.dart';

class GradientLine extends StatelessWidget {
  final String message;
  const GradientLine({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientLinePainter(message),
      child: const SizedBox(height: 150),
    );
  }
}

class GradientLinePainter extends CustomPainter {
  final String message;

  GradientLinePainter(this.message);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2
      ..shader = const LinearGradient(
        colors: [Colors.yellowAccent, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw the vertical gradient line
    canvas.drawLine(
      Offset(size.width / 2, 60), // Start below the message box
      Offset(size.width / 2, size.height),
      paint,
    );

    // Draw the circle at the top
    paint.shader = null;
    paint.color = Colors.yellowAccent;
    canvas.drawCircle(Offset(size.width / 2, 60), 6, paint);

    // Draw the message box
    TextSpan span = TextSpan(
      style: const TextStyle(color: Colors.white, fontSize: 10.0),
      text: message,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    double textWidth = tp.width;
    double textHeight = tp.height;

    // Draw a rectangle box for the message
    paint.color = Colors.black87;
    double boxWidth = textWidth + 20;
    double boxHeight = textHeight + 20;
    double boxLeft = (size.width - boxWidth) / 2;
    double boxTop = 0;

    // Draw the rectangle part of the speech bubble
    RRect bubbleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(boxLeft, boxTop, boxWidth, boxHeight),
      const Radius.circular(10),
    );
    canvas.drawRRect(bubbleRect, paint);

    // Draw the triangular "tail"
    Path path = Path();
    path.moveTo(size.width / 2 - 10, boxHeight);
    path.lineTo(size.width / 2, boxHeight + 10);
    path.lineTo(size.width / 2 + 10, boxHeight);
    path.close();
    canvas.drawPath(path, paint);

    // Draw the text inside the box
    tp.paint(canvas, Offset(boxLeft + 10, boxTop + 10));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
