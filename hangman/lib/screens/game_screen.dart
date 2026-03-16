import 'package:flutter/material.dart';
import 'package:hangman/components/handman_drawing.dart';
import '../models/subject.dart';

class GameScreen extends StatefulWidget {
  final Subject subject;

  const GameScreen({super.key, required this.subject});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameState _gameState;
  late List<String> _words;
  late String _currentWord;
  final Set<String> _usedLetters = {};
  bool _gameOver = false;
  bool _gameWon = false;
  final int _maxAttempts = 6;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _words = List.from(widget.subject.words)..shuffle();
    _currentWord = _words.first;
    _gameState = GameState(
      word: _currentWord,
      guessedLetters: {},
      wrongAttempts: 0,
      maxAttempts: _maxAttempts,
    );
    _usedLetters.clear();
    _gameOver = false;
    _gameWon = false;
  }

  void _nextWord() {
    setState(() {
      final currentIndex = _words.indexOf(_currentWord);
      if (currentIndex < _words.length - 1) {
        _currentWord = _words[currentIndex + 1];
        _gameState = GameState(
          word: _currentWord,
          guessedLetters: {},
          wrongAttempts: 0,
          maxAttempts: _maxAttempts,
        );
        _usedLetters.clear();
        _gameOver = false;
        _gameWon = false;
      } else {
        _showGameCompleteDialog();
      }
    });
  }

  void _guessLetter(String letter) {
    if (_gameOver || _gameWon || _usedLetters.contains(letter)) return;

    setState(() {
      _usedLetters.add(letter);
      
      if (_currentWord.toUpperCase().contains(letter)) {
        _gameState.guessedLetters.add(letter);
        if (_gameState.isWordGuessed) {
          _gameWon = true;
          _showWordGuessedDialog();
        }
      } else {
        _gameState.wrongAttempts++;
        if (_gameState.isGameOver) {
          _gameOver = true;
          _showGameOverDialog();
        }
      }
    });
  }

  void _showWordGuessedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🎉 Congratulations!'),
          content: Text('You guessed the word: ${_currentWord.toUpperCase()}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _nextWord();
              },
              child: const Text('Next Word'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Main Menu'),
            ),
          ],
        );
      },
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('😢 Game Over'),
          content: Text('The word was: ${_currentWord.toUpperCase()}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _initializeGame();
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Main Menu'),
            ),
          ],
        );
      },
    );
  }

  void _showGameCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🏆 Amazing!'),
          content: Text('You completed all words in ${widget.subject.name}!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Main Menu'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.subject.icon} ${widget.subject.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: widget.subject.color,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initializeGame,
            tooltip: 'New Game',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.subject.color.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            // Hangman drawing
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: HangmanDrawing(
                wrongAttempts: _gameState.wrongAttempts,
                maxAttempts: _gameState.maxAttempts,
              ),
            ),

            // Word display
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _gameState.wordDisplay
                      .map((letter) => Container(
                            width: 40,
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: widget.subject.color,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                letter,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),

            // Keyboard
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Keyboard(
                  onLetterSelected: _guessLetter,
                  usedLetters: _usedLetters,
                  subjectColor: widget.subject.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Keyboard extends StatelessWidget {
  final Function(String) onLetterSelected;
  final Set<String> usedLetters;
  final Color subjectColor;

  const Keyboard({
    super.key,
    required this.onLetterSelected,
    required this.usedLetters,
    required this.subjectColor,
  });

  @override
  Widget build(BuildContext context) {
    const letters = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate button size based on available width
        double buttonSize = (constraints.maxWidth - 40) / 10; // 40 for padding, 10 columns in first row
        buttonSize = buttonSize.clamp(30.0, 45.0); // Min 30, max 45
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: letters.asMap().entries.map((entry) {
            int rowIndex = entry.key;
            List<String> row = entry.value;
            
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((letter) {
                  final isUsed = usedLetters.contains(letter);
                  
                  // Adjust padding based on row
                  double horizontalPadding = rowIndex == 0 ? 3.0 : 
                                            (rowIndex == 1 ? 4.0 : 5.0);
                  
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Material(
                      color: isUsed ? Colors.grey.shade300 : subjectColor,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: isUsed ? null : () => onLetterSelected(letter),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: buttonSize,
                          height: buttonSize * 1.2, // Slightly taller than wide
                          alignment: Alignment.center,
                          child: Text(
                            letter,
                            style: TextStyle(
                              fontSize: buttonSize * 0.5, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: isUsed ? Colors.grey.shade600 : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

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
      (letter) => guessedLetters.contains(letter)
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