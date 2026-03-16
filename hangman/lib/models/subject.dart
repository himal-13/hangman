import 'package:flutter/material.dart';

class Subject {
  final String id;
  final String name;
  final String icon;
  final List<String> words;
  final Color color;

  Subject({
    required this.id,
    required this.name,
    required this.icon,
    required this.words,
    required this.color,
  });
}