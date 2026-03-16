import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ParticleEffect extends Component {
  final Vector2 position;
  final bool isCorrect;
  final VoidCallback? onComplete;

  ParticleEffect({
    required this.position,
    required this.isCorrect,
    this.onComplete,
  });

  @override
  Future<void> onLoad() async {
    final particleSystem = ParticleSystemComponent(
      particle: Particle.generate(
        count: 20,
        lifespan: 1.0,
        generator: (i) {
          final random = Random();
          final speed = random.nextDouble() * 200 + 100;
          final angle = random.nextDouble() * 2 * pi;
          final velocity = Vector2(cos(angle), sin(angle)) * speed;

          return MovingParticle(
            child: CircleParticle(
              radius: random.nextDouble() * 3 + 2,
              paint: Paint()..color = isCorrect ? Colors.green : Colors.red,
            ),
            from: position,
            to: position + velocity * 0.5,
            lifespan: 1.0,
          );
        },
      ),
    );

    add(particleSystem);

    // Remove after animation completes
    Future.delayed(const Duration(seconds: 1), () {
      removeFromParent();
      onComplete?.call();
    });
  }
}

class LetterRevealEffect extends Component {
  final Vector2 position;
  final String letter;
  final Color color;
  final VoidCallback? onComplete;

  LetterRevealEffect({
    required this.position,
    required this.letter,
    required this.color,
    this.onComplete,
  });

  @override
  Future<void> onLoad() async {
    final textComponent = TextComponent(
      text: letter,
      textRenderer: TextPaint(
        style: TextStyle(
          color: color,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: position,
      anchor: Anchor.center,
    );

    add(textComponent);

    // Remove after animation completes
    Future.delayed(const Duration(milliseconds: 600), () {
      removeFromParent();
      onComplete?.call();
    });
  }
}