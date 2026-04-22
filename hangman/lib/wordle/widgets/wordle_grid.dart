import 'package:flutter/material.dart';
import '../models/wordle_game_state.dart';

class WordleGrid extends StatelessWidget {
  final WordleGameState state;

  const WordleGrid({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(state.maxGuesses, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(state.wordLength, (colIndex) {
            return _buildCell(rowIndex, colIndex);
          }),
        );
      }),
    );
  }

  Widget _buildCell(int rowIndex, int colIndex) {
    String letter = '';
    LetterState letterState = LetterState.initial;

    if (rowIndex < state.guesses.length) {
      // Past guess
      String guess = state.guesses[rowIndex];
      letter = guess[colIndex];
      
      if (state.targetWord[colIndex] == letter) {
        letterState = LetterState.correct;
      } else if (state.targetWord.contains(letter)) {
        // Basic check for yellow (note: strict Wordle has more complex yellow rules, 
        // but since we only provide the letters of the target word, it's sufficient)
        letterState = LetterState.wrongPosition;
      } else {
        letterState = LetterState.notInWord;
      }
    } else if (rowIndex == state.guesses.length) {
      // Current guess
      if (colIndex < state.currentGuess.length) {
        letter = state.currentGuess[colIndex];
      }
    }

    Color bgColor;
    Color borderColor;
    Color textColor;

    switch (letterState) {
      case LetterState.initial:
        bgColor = Colors.transparent;
        borderColor = letter.isNotEmpty ? Colors.grey.shade500 : Colors.grey.shade300;
        textColor = Colors.black87;
        break;
      case LetterState.correct:
        bgColor = Colors.green;
        borderColor = Colors.green;
        textColor = Colors.white;
        break;
      case LetterState.wrongPosition:
        bgColor = Colors.orange;
        borderColor = Colors.orange;
        textColor = Colors.white;
        break;
      case LetterState.notInWord:
        bgColor = Colors.grey.shade600;
        borderColor = Colors.grey.shade600;
        textColor = Colors.white;
        break;
    }

    // Size cells dynamically based on word length
    double cellSize = 50.0;
    if (state.wordLength > 5) cellSize = 40.0;
    
    return Container(
      width: cellSize,
      height: cellSize,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          fontSize: cellSize * 0.5,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
