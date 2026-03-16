import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'particle_effects.dart';

class HangmanGame extends FlameGame {
  final int wrongAttempts;
  final int maxAttempts;
  final Color subjectColor;

  HangmanGame({
    required this.wrongAttempts,
    required this.maxAttempts,
    required this.subjectColor,
  });

  @override
  Future<void> onLoad() async {
    // Set up the game world
    final gallows = GallowsComponent(subjectColor: subjectColor);
    add(gallows);

    final hangman = HangmanComponent(
      wrongAttempts: wrongAttempts,
      maxAttempts: maxAttempts,
      subjectColor: subjectColor,
    );
    add(hangman);

    // Add particle effect for wrong attempts
    if (wrongAttempts > 0) {
      final particleEffect = ParticleEffect(
        position: Vector2(size.x / 2, size.y / 2),
        isCorrect: false,
      );
      add(particleEffect);
    }
  }

  @override
  Color backgroundColor() => Colors.transparent;
}

class GallowsComponent extends PositionComponent {
  final Color subjectColor;

  GallowsComponent({required this.subjectColor});

  @override
  void onLoad() {
    size = Vector2(130, 130);
    position = Vector2(0, 0);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = subjectColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final centerX = size.x / 2;
    final centerY = size.y / 2;

    // Scale factor for drawing
    const scale = 0.7;

    // Draw gallows
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
  }
}

class HangmanComponent extends PositionComponent {
  final int wrongAttempts;
  final int maxAttempts;
  final Color subjectColor;

  HangmanComponent({
    required this.wrongAttempts,
    required this.maxAttempts,
    required this.subjectColor,
  });

  @override
  void onLoad() {
    size = Vector2(130, 130);
    position = Vector2(0, 0);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.red.shade700
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final centerX = size.x / 2;
    final centerY = size.y / 2;

    // Scale factor for drawing
    const scale = 0.7;

    // Draw hangman based on wrong attempts
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
}