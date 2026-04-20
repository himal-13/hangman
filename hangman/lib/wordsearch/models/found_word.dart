// lib/wordgame/models/found_word.dart
import 'package:flutter/material.dart';

class FoundWord {
  final String word;
  final List<Offset> path;

  FoundWord(this.word, this.path);
}