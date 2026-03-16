import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'keyboard_game.dart';

class Keyboard extends StatefulWidget {
  final Function(String) onLetterSelected;
  final Set<String> usedLetters;
  final Color subjectColor;
  final bool useFlame;

  const Keyboard({
    super.key,
    required this.onLetterSelected,
    required this.usedLetters,
    required this.subjectColor,
    this.useFlame = true, // Default to Flame version
  });

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  late KeyboardGame game;

  @override
  void initState() {
    super.initState();
    if (widget.useFlame) {
      game = KeyboardGame(
        onLetterSelected: widget.onLetterSelected,
        usedLetters: widget.usedLetters,
        subjectColor: widget.subjectColor,
      );
    }
  }

  @override
  void didUpdateWidget(Keyboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.useFlame && (oldWidget.usedLetters != widget.usedLetters)) {
      // Recreate game with updated used letters
      game = KeyboardGame(
        onLetterSelected: widget.onLetterSelected,
        usedLetters: widget.usedLetters,
        subjectColor: widget.subjectColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useFlame) {
      return GameWidget(game: game);
    } else {
      return _buildTraditionalKeyboard();
    }
  }

  Widget _buildTraditionalKeyboard() {
    const _rows = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonSize = (constraints.maxWidth - 20) / 10;
        buttonSize = buttonSize.clamp(25.0, 38.0);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _rows.map((row) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((letter) {
                  final isUsed = widget.usedLetters.contains(letter);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: Material(
                      color: isUsed ? Colors.grey.shade300 : widget.subjectColor,
                      borderRadius: BorderRadius.circular(6),
                      child: InkWell(
                        onTap: isUsed ? null : () => widget.onLetterSelected(letter),
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          width: buttonSize * 0.9,
                          height: buttonSize * 0.9,
                          child: Center(
                            child: Text(
                              letter,
                              style: TextStyle(
                                fontSize: buttonSize * 0.35,
                                fontWeight: FontWeight.bold,
                                color: isUsed
                                    ? Colors.grey.shade600
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
