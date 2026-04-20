// lib/wordgame/models/word_search_level.dart
class WordSearchLevel {
  final int id;
  final String name;
  final String description;
  final int gridSize;
  final int wordCount;
  final List<String> words;
  final Map<String, String>? clues; // Map of Clue -> Word to find

  const WordSearchLevel({
    required this.id,
    required this.name,
    required this.description,
    required this.gridSize,
    required this.wordCount,
    required this.words,
    this.clues,
  });
}