import 'package:flutter/material.dart';
import '../data/wordle_level_data.dart';

class WordleMultiGameState extends ChangeNotifier {
  final WordleLevel level;

  late Map<String, int> globalLetterCounts;
  Map<String, int> consumedLetterCounts = {};
  late List<bool> solvedWords;
  int selectedWordIndex = 0;
  String currentInput = '';
  bool lastSubmitWrong = false;

  WordleMultiGameState({required this.level}) {
    _initGame();
  }

  void _initGame() {
    globalLetterCounts = {};
    consumedLetterCounts = {};
    solvedWords = List.filled(level.words.length, false);
    selectedWordIndex = 0;
    currentInput = '';
    lastSubmitWrong = false;

    for (final word in level.words) {
      for (final ch in word.split('')) {
        globalLetterCounts[ch] = (globalLetterCounts[ch] ?? 0) + 1;
      }
    }
  }

  bool get isLevelComplete => solvedWords.every((s) => s);

  /// Remaining usable count of a letter for the letter bank display.
  int getRemainingCount(String letter) {
    final global = globalLetterCounts[letter] ?? 0;
    final consumed = consumedLetterCounts[letter] ?? 0;
    final inInput = currentInput.split('').where((l) => l == letter).length;
    final remaining = global - consumed - inInput;
    return remaining < 0 ? 0 : remaining;
  }

  /// Sorted list of letters that still have at least 1 remaining count.
  List<String> get availableLetters {
    return globalLetterCounts.keys
        .where((l) => getRemainingCount(l) > 0)
        .toList()
      ..sort();
  }

  /// All unique letters (for showing exhausted ones greyed out).
  List<String> get allLetters {
    return globalLetterCounts.keys.toList()..sort();
  }

  void selectWord(int index) {
    if (solvedWords[index]) return;
    if (selectedWordIndex == index) return;
    currentInput = '';
    selectedWordIndex = index;
    notifyListeners();
  }

  void addLetter(String letter) {
    final targetWord = level.words[selectedWordIndex];
    if (currentInput.length >= targetWord.length) return;
    if (getRemainingCount(letter) <= 0) return;
    currentInput += letter;
    notifyListeners();
  }

  void removeLetter() {
    if (currentInput.isEmpty) return;
    currentInput = currentInput.substring(0, currentInput.length - 1);
    lastSubmitWrong = false;
    notifyListeners();
  }

  /// Returns true if correct, false if wrong.
  bool submitWord() {
    final targetWord = level.words[selectedWordIndex];
    if (currentInput.length != targetWord.length) return false;

    if (currentInput == targetWord) {
      solvedWords[selectedWordIndex] = true;
      for (final ch in currentInput.split('')) {
        consumedLetterCounts[ch] = (consumedLetterCounts[ch] ?? 0) + 1;
      }
      currentInput = '';
      lastSubmitWrong = false;
      // Auto-select next unsolved word
      for (int i = 0; i < level.words.length; i++) {
        if (!solvedWords[i]) {
          selectedWordIndex = i;
          break;
        }
      }
      notifyListeners();
      return true;
    } else {
      lastSubmitWrong = true;
      currentInput = '';
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _initGame();
    notifyListeners();
  }
}
