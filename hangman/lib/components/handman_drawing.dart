import 'package:flutter/material.dart';

class HangmanDrawing extends StatelessWidget {
  final int wrongAttempts;
  final int maxAttempts;

  const HangmanDrawing({
    super.key,
    required this.wrongAttempts,
    required this.maxAttempts,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: HangmanPainter(
        wrongAttempts: wrongAttempts,
        maxAttempts: maxAttempts,
      ),
    );
  }
}

class HangmanPainter extends CustomPainter {
  final int wrongAttempts;
  final int maxAttempts;

  HangmanPainter({
    required this.wrongAttempts,
    required this.maxAttempts,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw gallows
    canvas.drawLine(
      Offset(centerX - 60, centerY + 60),
      Offset(centerX + 60, centerY + 60),
      paint,
    ); // Base
    canvas.drawLine(
      Offset(centerX - 30, centerY + 60),
      Offset(centerX - 30, centerY - 60),
      paint,
    ); // Vertical pole
    canvas.drawLine(
      Offset(centerX - 30, centerY - 60),
      Offset(centerX + 30, centerY - 60),
      paint,
    ); // Top beam
    canvas.drawLine(
      Offset(centerX + 30, centerY - 60),
      Offset(centerX + 30, centerY - 40),
      paint,
    ); // Rope

    // Draw hangman based on wrong attempts
    if (wrongAttempts >= 1) {
      // Head
      canvas.drawCircle(
        Offset(centerX + 30, centerY - 30),
        15,
        paint,
      );
    }

    if (wrongAttempts >= 2) {
      // Body
      canvas.drawLine(
        Offset(centerX + 30, centerY - 15),
        Offset(centerX + 30, centerY + 15),
        paint,
      );
    }

    if (wrongAttempts >= 3) {
      // Left arm
      canvas.drawLine(
        Offset(centerX + 30, centerY - 10),
        Offset(centerX + 15, centerY),
        paint,
      );
    }

    if (wrongAttempts >= 4) {
      // Right arm
      canvas.drawLine(
        Offset(centerX + 30, centerY - 10),
        Offset(centerX + 45, centerY),
        paint,
      );
    }

    if (wrongAttempts >= 5) {
      // Left leg
      canvas.drawLine(
        Offset(centerX + 30, centerY + 15),
        Offset(centerX + 15, centerY + 30),
        paint,
      );
    }

    if (wrongAttempts >= 6) {
      // Right leg
      canvas.drawLine(
        Offset(centerX + 30, centerY + 15),
        Offset(centerX + 45, centerY + 30),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}