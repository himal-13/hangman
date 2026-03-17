import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hangman/audio/audio_manager.dart';

class GameSettingsProvider extends ChangeNotifier {
  static const String _hintsUsedKeyPrefix = 'hints_used_';
  static const String _soundMutedKey = 'sound_muted';
  static const String _maxHintsKey = 'max_hints';

  final Map<String, int> _hintsUsed = {};
  bool _soundMuted = false;
  int _maxHints = 3;

  bool get isSoundMuted => _soundMuted;
  int get maxHints => _maxHints;

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

    // Load other saved settings.
    _soundMuted = prefs.getBool(_soundMutedKey) ?? false;
    _maxHints = prefs.getInt(_maxHintsKey) ?? 3;

    // Keep audio manager in sync with saved sound setting.
    AudioManager.instance.setMuted(_soundMuted);

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

  Future<void> setSoundMuted(bool muted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundMutedKey, muted);

    _soundMuted = muted;
    AudioManager.instance.setMuted(muted);
    notifyListeners();
  }

  Future<void> setMaxHints(int maxHints) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_maxHintsKey, maxHints);

    _maxHints = maxHints;
    notifyListeners();
  }

  Future<void> resetHintUsage() async {
    final prefs = await SharedPreferences.getInstance();

    final hintKeys = prefs.getKeys().where((key) => key.startsWith(_hintsUsedKeyPrefix));
    for (var key in hintKeys) {
      await prefs.remove(key);
    }

    _hintsUsed.clear();
    notifyListeners();
  }

  bool canUseHint(String subjectId, String word) {
    return getHintsUsed(subjectId, word) < _maxHints;
  }
}