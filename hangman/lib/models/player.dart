import 'package:flutter/material.dart';

class MultiplayerPlayer {
  final int id;
  String name;
  final Color color;
  
  int score = 0;
  int wrongAttempts = 0;
  int maxAttempts = 6;

  MultiplayerPlayer({
    required this.id,
    required this.name,
    required this.color,
  });

  void resetGameStats(int totalMaxAttempts) {
    score = 0;
    wrongAttempts = 0;
    maxAttempts = totalMaxAttempts;
  }

  bool get isGameOver => wrongAttempts >= maxAttempts;
}
