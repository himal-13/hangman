class GameState {
  final String word;
  final Set<String> guessedLetters;
  int wrongAttempts;
  final int maxAttempts;

  GameState({
    required this.word,
    required this.guessedLetters,
    required this.wrongAttempts,
    required this.maxAttempts,
  });

  bool get isWordGuessed {
    return word.toUpperCase().split('').every(
      (letter) => guessedLetters.contains(letter),
    );
  }

  bool get isGameOver => wrongAttempts >= maxAttempts;

  List<String> get wordDisplay {
    return word.toUpperCase().split('').map((letter) {
      return guessedLetters.contains(letter) ? letter : '_';
    }).toList();
  }

  String get remainingAttempts => '${maxAttempts - wrongAttempts}';
}
