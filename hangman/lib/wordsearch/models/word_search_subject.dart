import 'package:flutter/material.dart';
import 'word_search_level.dart';

class WordSearchSubject {
  final String id;
  final String name;
  final String icon;
  final List<WordSearchLevel> levels;
  final Color color;

  const WordSearchSubject({
    required this.id,
    required this.name,
    required this.icon,
    required this.levels,
    required this.color,
  });
}
