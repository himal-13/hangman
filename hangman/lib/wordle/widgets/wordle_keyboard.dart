import 'package:flutter/material.dart';
import '../models/wordle_game_state.dart';

class WordleKeyboard extends StatelessWidget {
  final WordleGameState state;

  const WordleKeyboard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    // Get unique letters of the target word, sorted alphabetically
    List<String> availableLetters = state.letterCounts.keys.toList()..sort();

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 12,
          children: availableLetters.map((letter) {
            return _buildKey(context, letter);
          }).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionKey(
              context,
              icon: Icons.backspace_outlined,
              label: 'DEL',
              onTap: state.removeLetter,
            ),
            const SizedBox(width: 16),
            _buildActionKey(
              context,
              icon: Icons.keyboard_return,
              label: 'ENTER',
              onTap: state.submitGuess,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKey(BuildContext context, String letter) {
    int totalCount = state.getTargetLetterCount(letter);
    
    // Calculate how many times this letter has been used in the current guess
    int usedCount = 0;
    for (int i = 0; i < state.currentGuess.length; i++) {
      if (state.currentGuess[i] == letter) {
        usedCount++;
      }
    }
    
    int remainingCount = totalCount - usedCount;
    if (remainingCount < 0) remainingCount = 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: remainingCount > 0 ? Colors.blue.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: remainingCount > 0 ? () => state.addLetter(letter) : null,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 48,
              height: 56,
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: remainingCount > 0 ? Colors.blue.shade900 : Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ),
        // Sudoku-style count badge
        Positioned(
          top: -6,
          right: -6,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: remainingCount > 0 ? Colors.blue.shade600 : Colors.grey.shade500,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$remainingCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionKey(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return Material(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: Colors.black87),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
