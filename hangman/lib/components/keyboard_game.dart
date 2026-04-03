import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class KeyboardGame extends FlameGame with TapDetector {
  final Function(String) onLetterSelected;
  final Set<String> usedLetters;
  final Color subjectColor;

  KeyboardGame({
    required this.onLetterSelected,
    required this.usedLetters,
    required this.subjectColor,
  });

  static const _rows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  @override
  Future<void> onLoad() async {
    // Create keyboard buttons
    double buttonWidth = (size.x - 20) / 10;
    if (buttonWidth > 40) buttonWidth = 40; // max size limit
    double buttonHeight = buttonWidth;
    double spacing = buttonWidth * 0.1;

    double yOffset = 10;
    for (final row in _rows) {
      double rowWidth = row.length * (buttonWidth + spacing) - spacing;
      double xOffset = (size.x - rowWidth) / 2;

      for (final letter in row) {
        final isUsed = usedLetters.contains(letter);
        final button = KeyboardButton(
          letter: letter,
          position: Vector2(xOffset, yOffset),
          sizeOverride: Vector2(buttonWidth, buttonHeight),
          isUsed: isUsed,
          subjectColor: subjectColor,
          onTap: () {
            if (!isUsed) {
              onLetterSelected(letter);
            }
          },
        );
        add(button);
        xOffset += buttonWidth + spacing;
      }
      yOffset += buttonHeight + spacing + 5;
    }
  }

  @override
  Color backgroundColor() => Colors.transparent;
}

class KeyboardButton extends PositionComponent with TapCallbacks {
  final String letter;
  final bool isUsed;
  final Color subjectColor;
  final VoidCallback onTap;
  final Vector2 sizeOverride;

  KeyboardButton({
    required this.letter,
    required super.position,
    required this.isUsed,
    required this.subjectColor,
    required this.onTap,
    Vector2? sizeOverride,
  }) : sizeOverride = sizeOverride ?? Vector2(40, 40) {
    size = this.sizeOverride;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = isUsed ? Colors.grey.shade300 : subjectColor
      ..style = PaintingStyle.fill;

    // Draw button background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.x, size.y),
        const Radius.circular(6),
      ),
      paint,
    );

    // Draw border
    final borderPaint = Paint()
      ..color = isUsed ? Colors.grey.shade500 : subjectColor.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.x, size.y),
        const Radius.circular(6),
      ),
      borderPaint,
    );

    // Draw letter text
    final textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          color: isUsed ? Colors.grey.shade600 : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - textPainter.width) / 2,
        (size.y - textPainter.height) / 2,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!isUsed) {
      onTap();
    }
  }
}