import 'package:flutter/material.dart';
import '../data/wordle_words.dart';

enum LetterState { initial, correct, wrongPosition, notInWord }

class WordleGameState extends ChangeNotifier {
  final int level;
  late String targetWord;
  late int wordLength;
  
  List<String> guesses = [];
  String currentGuess = '';
  int maxGuesses = 6;
  bool isGameOver = false;
  bool isGameWon = false;

  Map<String, int> letterCounts = {};

  WordleGameState({required this.level}) {
    _initGame();
  }

  void _initGame() {
    targetWord = WordleWords.getRandomWord(level);
    wordLength = targetWord.length;
    
    // Count occurrences of each letter in the target word
    letterCounts.clear();
    for (int i = 0; i < targetWord.length; i++) {
      String letter = targetWord[i];
      letterCounts[letter] = (letterCounts[letter] ?? 0) + 1;
    }
  }

  void reset() {
    guesses.clear();
    currentGuess = '';
    isGameOver = false;
    isGameWon = false;
    _initGame();
    notifyListeners();
  }

  void addLetter(String letter) {
    if (isGameOver || currentGuess.length >= wordLength) return;
    currentGuess += letter;
    notifyListeners();
  }

  void removeLetter() {
    if (isGameOver || currentGuess.isEmpty) return;
    currentGuess = currentGuess.substring(0, currentGuess.length - 1);
    notifyListeners();
  }

  void submitGuess() {
    if (isGameOver || currentGuess.length != wordLength) return;
    
    guesses.add(currentGuess);
    
    if (currentGuess == targetWord) {
      isGameOver = true;
      isGameWon = true;
    } else if (guesses.length >= maxGuesses) {
      isGameOver = true;
    }
    
    currentGuess = '';
    notifyListeners();
  }

  // Returns the count of a specific letter remaining to be discovered.
  // We can just show the total count in the target word as requested "like in sudoku".
  int getTargetLetterCount(String letter) {
    return letterCounts[letter] ?? 0;
  }
}
