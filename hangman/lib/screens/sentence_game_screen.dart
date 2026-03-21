import 'package:flutter/material.dart';
import 'package:hangman/models/game_state.dart';
import 'package:hangman/services/game_progress.dart';
import 'package:hangman/services/game_setting.dart';
import 'package:hangman/audio/audio_manager.dart';
import 'package:provider/provider.dart';
import 'package:hangman/components/hangman_drawing.dart';
import '../models/subject.dart';

class SentenceGameScreen extends StatefulWidget {
  final Subject subject;

  const SentenceGameScreen({super.key, required this.subject});

  @override
  State<SentenceGameScreen> createState() => _SentenceGameScreenState();
}

class _SentenceGameScreenState extends State<SentenceGameScreen> {
  late GameState _gameState;
  late List<String> _words;
  late String _currentWord;
  late int _currentWordIndex;
  final Set<String> _usedLetters = {};
  bool _gameOver = false;
  bool _gameWon = false;
  final int _maxAttempts = 6;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGame();
  }

  Future<void> _loadGame() async {
    final progressProvider = Provider.of<GameProgressProvider>(context, listen: false);
    _currentWordIndex = progressProvider.getCurrentWordIndex(widget.subject.id);
    _initializeGame();
    setState(() {
      _isLoading = false;
    });
  }

  void _initializeGame() {
    _words = List.from(widget.subject.words);
    _currentWord = _words[_currentWordIndex];
    
    // Fixed letters to reveal: Spaces and Vowels as per "fixed letter" requirement
    final Set<String> preRevealed = {' ', 'A', 'E', 'I', 'O', 'U'};
    
    _gameState = GameState(
      word: _currentWord,
      guessedLetters: {},
      wrongAttempts: 0,
      maxAttempts: _maxAttempts,
    );
    
    // Add pre-revealed letters that exist in the word
    for (var char in _currentWord.toUpperCase().split('')) {
      if (preRevealed.contains(char)) {
        _gameState.guessedLetters.add(char);
      }
    }
    
    _usedLetters.clear();
    _usedLetters.addAll(preRevealed.where((l) => l != ' '));
    
    _gameOver = false;
    _gameWon = false;
  }

  void _nextWord() {
    setState(() {
      if (_currentWordIndex < _words.length - 1) {
        _currentWordIndex++;
        _currentWord = _words[_currentWordIndex];
        _initializeGame();
        
        // Save current word index
        Provider.of<GameProgressProvider>(context, listen: false)
            .updateCurrentWordIndex(widget.subject.id, _currentWordIndex);
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
        AudioManager.instance.playCorrect();
        if (_gameState.isWordGuessed) {
          _gameWon = true;
          _handleWordCompletion();
        }
      } else {
        _gameState.wrongAttempts++;
        AudioManager.instance.playWrong();
        if (_gameState.isGameOver) {
          _gameOver = true;
          AudioManager.instance.playLose();
          _showGameOverDialog();
        }
      }
    });
  }

  void _useHint() {
    final settingsProvider = Provider.of<GameSettingsProvider>(context, listen: false);

    final wordLetters = _currentWord.toUpperCase().split('');
    final unguessedLetters = wordLetters
        .where((letter) => letter != ' ' && !_gameState.guessedLetters.contains(letter))
        .toSet()
        .toList();

    if (unguessedLetters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No letters left to hint!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (settingsProvider.availableHints <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Out of hints! Claim daily hints on the home screen.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    settingsProvider.useHint();
    _giveHint(unguessedLetters);
  }

  void _giveHint(List<String> unguessedLetters) {
    final hintLetter = unguessedLetters[
      DateTime.now().millisecondsSinceEpoch % unguessedLetters.length
    ];
    _guessLetter(hintLetter);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('💡 Hint: Revealed "$hintLetter"'),
        backgroundColor: Colors.amber.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleWordCompletion() async {
    final progressProvider = Provider.of<GameProgressProvider>(context, listen: false);
    await progressProvider.markWordAsCompleted(widget.subject.id, _currentWord);
    AudioManager.instance.playWin();
    
    final completedWords = progressProvider.getCompletedWords(widget.subject.id);
    final isSubjectComplete = completedWords.length >= _words.length;
    
    if (isSubjectComplete) {
      _showGameCompleteDialog();
    } else {
      _showWordGuessedDialog();
    }
  }

  void _showWordGuessedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green.shade400, Colors.green.shade600],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎉 EXCELLENT!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 15),
                Text(_currentWord.toUpperCase(), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDialogButton(icon: Icons.play_arrow_rounded, label: 'NEXT', color: Colors.white, textColor: Colors.green.shade700, onPressed: () {
                      Navigator.pop(context);
                      _nextWord();
                    }),
                    _buildDialogButton(icon: Icons.home_rounded, label: 'MENU', color: Colors.white.withOpacity(0.3), textColor: Colors.white, onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.red.shade400, Colors.red.shade600],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('😢 GAME OVER', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 15),
                Text('The sentence was:\n$_currentWord', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDialogButton(icon: Icons.refresh_rounded, label: 'RETRY', color: Colors.white, textColor: Colors.red.shade700, onPressed: () {
                      Navigator.pop(context);
                      _initializeGame();
                    }),
                    _buildDialogButton(icon: Icons.home_rounded, label: 'MENU', color: Colors.white.withOpacity(0.3), textColor: Colors.white, onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGameCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple.shade400, Colors.purple.shade700],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🏆 AMAZING!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 10),
                Text('You completed all sentences in\n${widget.subject.name}!', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                _buildDialogButton(icon: Icons.home_rounded, label: 'BACK TO MENU', color: Colors.white, textColor: Colors.purple.shade700, onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, isFullWidth: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogButton({required IconData icon, required String label, required Color color, required Color textColor, required VoidCallback onPressed, bool isFullWidth = false}) {
    return Expanded(
      flex: isFullWidth ? 0 : 1,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20, color: textColor),
                const SizedBox(width: 5),
                Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject.icon} Sentence Mode'),
        backgroundColor: widget.subject.color,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _initializeGame),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [widget.subject.color.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: HangmanDrawing(
                wrongAttempts: _gameState.wrongAttempts,
                maxAttempts: _maxAttempts,
                subjectColor: widget.subject.color,
              ),
            ),
            
            // Sentence Display
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 12,
                    children: _currentWord.split('').map((char) {
                      if (char == ' ') {
                        return const SizedBox(width: 20);
                      }
                      bool isRevealed = _gameState.guessedLetters.contains(char.toUpperCase());
                      return Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: widget.subject.color, width: 2)),
                        ),
                        child: Center(
                          child: Text(
                            isRevealed ? char.toUpperCase() : '',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Keyboard
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _useHint,
                        icon: const Icon(Icons.lightbulb),
                        label: Consumer<GameSettingsProvider>(
                          builder: (context, settings, _) => Text('Hint (${settings.availableHints})'),
                        ),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade100, foregroundColor: Colors.amber.shade900),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildKeyboard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    const rows = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
    ];

    return Column(
      children: rows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map((letter) {
            bool isUsed = _usedLetters.contains(letter);
            bool isCorrect = _currentWord.toUpperCase().contains(letter);
            
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: InkWell(
                onTap: isUsed ? null : () => _guessLetter(letter),
                child: Container(
                  width: 35,
                  height: 45,
                  decoration: BoxDecoration(
                    color: isUsed 
                        ? (isCorrect ? Colors.green.shade200 : Colors.grey.shade300)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [if (!isUsed) BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))],
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUsed ? Colors.black38 : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
