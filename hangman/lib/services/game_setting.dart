import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hangman/audio/audio_manager.dart';

class GameSettingsProvider extends ChangeNotifier {
  static const String _availableHintsKey = 'available_hints';
  static const String _soundMutedKey = 'sound_muted';

  int _availableHints = 1; // Provide 3 initial free hints
  bool _soundMuted = false;

  int get availableHints => _availableHints;
  bool get isSoundMuted => _soundMuted;

  GameSettingsProvider() {
    loadSettings();
  }
  
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _availableHints = prefs.getInt(_availableHintsKey) ?? 3;
    _soundMuted = prefs.getBool(_soundMutedKey) ?? false;

    // Keep audio manager in sync with saved sound setting.
    AudioManager.instance.setMuted(_soundMuted);

    notifyListeners();
  }
  
  Future<void> useHint() async {
    if (_availableHints > 0) {
      _availableHints--;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_availableHintsKey, _availableHints);
      notifyListeners();
    }
  }

  Future<void> addHints(int count) async {
    _availableHints += count;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_availableHintsKey, _availableHints);
    notifyListeners();
  }

  Future<void> setSoundMuted(bool muted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundMutedKey, muted);

    _soundMuted = muted;
    AudioManager.instance.setMuted(muted);
    notifyListeners();
  }
}