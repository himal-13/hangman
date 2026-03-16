import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameProgressProvider extends ChangeNotifier {
  static const String _progressKeyPrefix = 'game_progress_';
  static const String _completedWordsKeyPrefix = 'completed_words_';
  
  Map<String, int> _currentWordIndices = {};
  Map<String, List<String>> _completedWords = {};
  
  GameProgressProvider() {
    loadProgress();
  }
  
  // Getters
  int getCurrentWordIndex(String subjectId) {
    return _currentWordIndices[subjectId] ?? 0;
  }
  
  List<String> getCompletedWords(String subjectId) {
    return _completedWords[subjectId] ?? [];
  }
  
  bool isWordCompleted(String subjectId, String word) {
    return _completedWords[subjectId]?.contains(word) ?? false;
  }
  
  double getProgressPercentage(String subjectId, int totalWords) {
    final completed = getCompletedWords(subjectId).length;
    return totalWords > 0 ? completed / totalWords : 0;
  }
  
  // Load progress from SharedPreferences
  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load current indices
    final indices = prefs.getKeys().where((key) => key.startsWith(_progressKeyPrefix));
    for (var key in indices) {
      final subjectId = key.substring(_progressKeyPrefix.length);
      _currentWordIndices[subjectId] = prefs.getInt(key) ?? 0;
    }
    
    // Load completed words
    final completedKeys = prefs.getKeys().where((key) => key.startsWith(_completedWordsKeyPrefix));
    for (var key in completedKeys) {
      final subjectId = key.substring(_completedWordsKeyPrefix.length);
      _completedWords[subjectId] = prefs.getStringList(key) ?? [];
    }
    
    notifyListeners();
  }
  
  // Update current word index
  Future<void> updateCurrentWordIndex(String subjectId, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_progressKeyPrefix + subjectId, index);
    _currentWordIndices[subjectId] = index;
    notifyListeners();
  }
  
  // Mark word as completed
  Future<void> markWordAsCompleted(String subjectId, String word) async {
    if (!_completedWords.containsKey(subjectId)) {
      _completedWords[subjectId] = [];
    }
    
    if (!_completedWords[subjectId]!.contains(word)) {
      _completedWords[subjectId]!.add(word);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_completedWordsKeyPrefix + subjectId, _completedWords[subjectId]!);
      notifyListeners();
    }
  }
  
  // Reset progress for a subject
  Future<void> resetProgress(String subjectId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKeyPrefix + subjectId);
    await prefs.remove(_completedWordsKeyPrefix + subjectId);
    
    _currentWordIndices.remove(subjectId);
    _completedWords.remove(subjectId);
    
    notifyListeners();
  }
  
  // Reset all progress
  Future<void> resetAllProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final keysToRemove = prefs.getKeys().where((key) => 
      key.startsWith(_progressKeyPrefix) || key.startsWith(_completedWordsKeyPrefix)
    );
    
    for (var key in keysToRemove) {
      await prefs.remove(key);
    }
    
    _currentWordIndices.clear();
    _completedWords.clear();
    
    notifyListeners();
  }
  
  // Check if all words in a subject are completed
  bool isSubjectCompleted(String subjectId, int totalWords) {
    return getCompletedWords(subjectId).length >= totalWords;
  }
}