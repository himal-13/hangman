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
      size: const Size(130, 130),
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
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Scale factor for smaller drawing
    const scale = 0.7;
    
    // Draw gallows (scaled down)
    canvas.drawLine(
      Offset(centerX - 40 * scale, centerY + 40 * scale),
      Offset(centerX + 40 * scale, centerY + 40 * scale),
      paint,
    ); // Base
    canvas.drawLine(
      Offset(centerX - 20 * scale, centerY + 40 * scale),
      Offset(centerX - 20 * scale, centerY - 40 * scale),
      paint,
    ); // Vertical pole
    canvas.drawLine(
      Offset(centerX - 20 * scale, centerY - 40 * scale),
      Offset(centerX + 20 * scale, centerY - 40 * scale),
      paint,
    ); // Top beam
    canvas.drawLine(
      Offset(centerX + 20 * scale, centerY - 40 * scale),
      Offset(centerX + 20 * scale, centerY - 30 * scale),
      paint,
    ); // Rope

    // Draw hangman based on wrong attempts (scaled down)
    if (wrongAttempts >= 1) {
      // Head
      canvas.drawCircle(
        Offset(centerX + 20 * scale, centerY - 20 * scale),
        10 * scale,
        paint,
      );
    }

    if (wrongAttempts >= 2) {
      // Body
      canvas.drawLine(
        Offset(centerX + 20 * scale, centerY - 10 * scale),
        Offset(centerX + 20 * scale, centerY + 10 * scale),
        paint,
      );
    }

    if (wrongAttempts >= 3) {
      // Left arm
      canvas.drawLine(
        Offset(centerX + 20 * scale, centerY - 7 * scale),
        Offset(centerX + 10 * scale, centerY),
        paint,
      );
    }

    if (wrongAttempts >= 4) {
      // Right arm
      canvas.drawLine(
        Offset(centerX + 20 * scale, centerY - 7 * scale),
        Offset(centerX + 30 * scale, centerY),
        paint,
      );
    }

    if (wrongAttempts >= 5) {
      // Left leg
      canvas.drawLine(
        Offset(centerX + 20 * scale, centerY + 10 * scale),
        Offset(centerX + 10 * scale, centerY + 20 * scale),
        paint,
      );
    }

    if (wrongAttempts >= 6) {
      // Right leg
      canvas.drawLine(
        Offset(centerX + 20 * scale, centerY + 10 * scale),
        Offset(centerX + 30 * scale, centerY + 20 * scale),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}