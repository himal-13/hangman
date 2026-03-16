import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameSettingsProvider extends ChangeNotifier {
  static const String _hintsUsedKeyPrefix = 'hints_used_';
  
  Map<String, int> _hintsUsed = {};
  
  GameSettingsProvider() {
    loadSettings();
  }
  
  int getHintsUsed(String subjectId, String word) {
    return _hintsUsed['${subjectId}_$word'] ?? 0;
  }
  
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final hintKeys = prefs.getKeys().where((key) => key.startsWith(_hintsUsedKeyPrefix));
    
    for (var key in hintKeys) {
      final id = key.substring(_hintsUsedKeyPrefix.length);
      _hintsUsed[id] = prefs.getInt(key) ?? 0;
    }
    
    notifyListeners();
  }
  
  Future<void> incrementHintUsed(String subjectId, String word) async {
    final key = '${subjectId}_$word';
    final current = getHintsUsed(subjectId, word);
    final newValue = current + 1;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_hintsUsedKeyPrefix + key, newValue);
    
    _hintsUsed[key] = newValue;
    notifyListeners();
  }
  
  int getMaxHints() {
    return 3; // Maximum 3 hints per word
  }
  
  bool canUseHint(String subjectId, String word) {
    return getHintsUsed(subjectId, word) < getMaxHints();
  }
}