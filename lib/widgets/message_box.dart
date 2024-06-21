import 'package:flutter/material.dart';

class MessageBoxPainter extends CustomPainter {
  final String message;

  MessageBoxPainter(this.message);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black87;

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

    // Draw the triangular "tail" on the right side
    Path path = Path();
    path.moveTo(boxLeft + boxWidth, boxHeight / 2 - 10);
    path.lineTo(boxLeft + boxWidth + 10, boxHeight / 2);
    path.lineTo(boxLeft + boxWidth, boxHeight / 2 + 10);
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

class MessageBox extends StatelessWidget {
  final String message;
  const MessageBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MessageBoxPainter(message),
      child: const SizedBox(height: 50), // Adjust height as needed
    );
  }
}
