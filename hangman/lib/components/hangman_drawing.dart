import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'hangman_game.dart';

class HangmanDrawing extends StatefulWidget {
  final int wrongAttempts;
  final int maxAttempts;
  final Color subjectColor;

  const HangmanDrawing({
    super.key,
    required this.wrongAttempts,
    required this.maxAttempts,
    required this.subjectColor,
  });

  @override
  State<HangmanDrawing> createState() => _HangmanDrawingState();
}

class _HangmanDrawingState extends State<HangmanDrawing> {
  late HangmanGame game;

  @override
  void initState() {
    super.initState();
    game = HangmanGame(
      wrongAttempts: widget.wrongAttempts,
      maxAttempts: widget.maxAttempts,
      subjectColor: widget.subjectColor,
    );
  }

  @override
  void didUpdateWidget(HangmanDrawing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.wrongAttempts != widget.wrongAttempts) {
      // Recreate game with new attempts
      game = HangmanGame(
        wrongAttempts: widget.wrongAttempts,
        maxAttempts: widget.maxAttempts,
        subjectColor: widget.subjectColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}