import 'package:flutter/material.dart';

class Sentence {
  final String id;
  final String text;
  final List<String> preRevealedLetters;
  final String category;
  final Color color;

  Sentence({
    required this.id,
    required this.text,
    required this.preRevealedLetters,
    required this.category,
    required this.color,
  });
}
