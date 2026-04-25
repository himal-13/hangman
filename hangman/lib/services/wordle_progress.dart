import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:hangman/wordle/data/wordle_level_data.dart';

class WordleProgress {
  static const String _latestUnlockedLevelKey = 'wordle_latest_unlocked_level';

  static int _clampLevel(int level) {
    if (level < 1) return 1;
    if (level > WordleLevelData.levels.length) {
      return WordleLevelData.levels.length;
    }
    return level;
  }

  static Future<int> getLatestUnlockedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    final level = prefs.getInt(_latestUnlockedLevelKey) ?? 1;
    return _clampLevel(level);
  }

  static Future<void> unlockNextLevel(int completedLevel) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_latestUnlockedLevelKey) ?? 1;
    final next = _clampLevel(max(current, completedLevel + 1));
    await prefs.setInt(_latestUnlockedLevelKey, next);
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_latestUnlockedLevelKey);
  }
}
