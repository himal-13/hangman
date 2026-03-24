import 'package:flutter/material.dart';

class Subject {
  final String id;
  final String name;
  final String icon;
  final List<String> words;
  final Map<String, String> wordHints;
  final Color color;

  Subject({
    required this.id,
    required this.name,
    required this.icon,
    required this.words,
    required this.wordHints,
    required this.color,
  });

  // Helper method to get current word based on progress
  String getCurrentWord(int currentIndex) {
    if (currentIndex >= 0 && currentIndex < words.length) {
      return words[currentIndex];
    }
    return words.first;
  }

  // Check if all words are completed
  bool isComplete(List<String> completedWords) {
    return completedWords.length >= words.length;
  }
}