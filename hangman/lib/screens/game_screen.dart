import 'package:flutter/material.dart';
import 'package:hangman/services/game_progress.dart';
import 'package:hangman/services/game_setting.dart';
import 'package:hangman/audio/audio_manager.dart';
import 'package:provider/provider.dart';
import 'package:hangman/components/hangman_drawing.dart';
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
      if (_currentWordIndex < _words.length - 1) {
        _currentWordIndex++;
        _currentWord = _words[_currentWordIndex];
        _gameState = GameState(
          word: _currentWord,
          guessedLetters: {},
          wrongAttempts: 0,
          maxAttempts: _maxAttempts,
        );
        _usedLetters.clear();
        _gameOver = false;
        _gameWon = false;
        
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

    // Find unguessed letters
    final wordLetters = _currentWord.toUpperCase().split('');
    final unguessedLetters = wordLetters
        .where((letter) => !_gameState.guessedLetters.contains(letter))
        .toSet()
        .toList();

    if (unguessedLetters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No letters to hint!'),
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

    // Deduct a hint
    settingsProvider.useHint();
    _giveHint(unguessedLetters, settingsProvider);
  }


  void _giveHint(List<String> unguessedLetters, GameSettingsProvider settingsProvider) {
    // Pick a random unguessed letter
    final hintLetter = unguessedLetters[
      DateTime.now().millisecondsSinceEpoch % unguessedLetters.length
    ];

    // Automatically guess that letter
    _guessLetter(hintLetter);

    // Show hint message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('💡 Hint: Confirmed "$hintLetter"'),
        backgroundColor: Colors.amber.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleWordCompletion() async {
    final progressProvider = Provider.of<GameProgressProvider>(context, listen: false);
    
    // Mark word as completed
    await progressProvider.markWordAsCompleted(widget.subject.id, _currentWord);
    
    // Play win sound
    AudioManager.instance.playWin();
    
    // Check if this was the last word in the subject
    final completedWords = progressProvider.getCompletedWords(widget.subject.id);
    final isSubjectComplete = completedWords.length >= _words.length;
    
    if (isSubjectComplete) {
      _showGameCompleteDialog();
    } else {
      _showWordGuessedDialog();
    }
  }

  // Update dialog methods to use _handleWordCompletion instead of _showWordGuessedDialog
  // And update _showWordGuessedDialog to not call _nextWord directly

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
                colors: [
                  Colors.green.shade400,
                  Colors.green.shade600,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade800.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated trophy icon
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
                  child: Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned.fill(
                        child: Icon(
                          Icons.emoji_events_rounded,
                          size: 60,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Success message
                const Text(
                  '🎉 EXCELLENT!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Word revealed
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    _currentWord.toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Progress info
                Consumer<GameProgressProvider>(
                  builder: (context, progress, child) {
                    final completed = progress.getCompletedWords(widget.subject.id).length;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Progress: $completed/${_words.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
                
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDialogButton(
                      icon: Icons.play_arrow_rounded,
                      label: _currentWordIndex < _words.length - 1 ? 'NEXT' : 'FINISH',
                      color: Colors.white,
                      textColor: Colors.green.shade700,
                      onPressed: () {
                        Navigator.pop(context);
                        if (_currentWordIndex < _words.length - 1) {
                          _nextWord();
                        } else {
                          _showGameCompleteDialog();
                        }
                      },
                    ),
                    _buildDialogButton(
                      icon: Icons.home_rounded,
                      label: 'MENU',
                      color: Colors.white.withOpacity(0.3),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 5),
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
                colors: [
                  Colors.red.shade400,
                  Colors.red.shade600,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.shade800.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
                  child: Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Positioned.fill(
                        child: Icon(
                          Icons.sentiment_dissatisfied_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Text(
                  '😢 GAME OVER',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 15),
                                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDialogButton(
                      icon: Icons.refresh_rounded,
                      label: 'RETRY',
                      color: Colors.white,
                      textColor: Colors.red.shade700,
                      onPressed: () {
                        Navigator.pop(context);
                        _initializeGame();
                      },
                    ),
                    _buildDialogButton(
                      icon: Icons.home_rounded,
                      label: 'MENU',
                      color: Colors.white.withOpacity(0.3),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 5),
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
                colors: [
                  Colors.purple.shade400,
                  Colors.purple.shade700,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.shade800.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_rounded, size: 40, color: Colors.yellow.shade300),
                      const SizedBox(width: 5),
                      Icon(Icons.emoji_events_rounded, size: 60, color: Colors.yellow.shade600),
                      const SizedBox(width: 5),
                      Icon(Icons.star_rounded, size: 40, color: Colors.yellow.shade300),
                    ],
                  ),
                ),
                
                Text(
                  '🏆 AMAZING!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade300,
                    letterSpacing: 1.5,
                    shadows: const [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 10),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    'You completed all words in\n${widget.subject.name}!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '${_words.length} words mastered',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 15),
                
                _buildDialogButton(
                  icon: Icons.home_rounded,
                  label: 'BACK TO MENU',
                  color: Colors.white,
                  textColor: Colors.purple.shade700,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  isFullWidth: true,
                ),
                
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    bool isFullWidth = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20, color: textColor),
                  const SizedBox(width: 5),
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.subject.icon} ${widget.subject.name}'),
          backgroundColor: widget.subject.color,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Provider.of<GameProgressProvider>(context)),
        ChangeNotifierProvider.value(value: Provider.of<GameSettingsProvider>(context)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.subject.icon} ${widget.subject.name}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          backgroundColor: widget.subject.color,
          elevation: 0,
          actions: [
            // Word counter
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_currentWordIndex + 1}/${_words.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _initializeGame,
              tooltip: 'Restart Word',
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
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 130,
                  child: Center(
                    child: HangmanDrawing(
                      wrongAttempts: _gameState.wrongAttempts,
                      maxAttempts: _maxAttempts,
                      subjectColor: widget.subject.color,
                    ),
                  ),
                ),
              ),

              // Word display
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final wordDisplay = _gameState.wordDisplay;
                      
                      if (wordDisplay.length > 8) {
                        final midPoint = (wordDisplay.length / 2).ceil();
                        final firstLine = wordDisplay.take(midPoint).toList();
                        final secondLine = wordDisplay.skip(midPoint).toList();
                        
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildWordLine(firstLine),
                            const SizedBox(height: 8),
                            _buildWordLine(secondLine),
                          ],
                        );
                      } else {
                        return Center(
                          child: _buildWordLine(wordDisplay),
                        );
                      }
                    },
                  ),
                ),
              ),

              // Attempts indicator
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: widget.subject.color, width: 1),
                      ),
                      child: Text(
                        '${_gameState.remainingAttempts} attempts left',
                        style: TextStyle(
                          color: widget.subject.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Keyboard
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Hint and Next Buttons Header
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Hint Button
                            Consumer<GameSettingsProvider>(
                              builder: (context, settings, child) {
                                final availableHints = settings.availableHints;
                                
                                return ElevatedButton.icon(
                                  onPressed: !_gameOver && !_gameWon ? _useHint : null,
                                  icon: const Icon(Icons.lightbulb, size: 18),
                                  label: Text(
                                    'Hint ($availableHints)',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber.shade500,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: Colors.grey.shade300,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                );
                              },
                            ),
                            
                            // Restart Button
                            ElevatedButton.icon(
                              onPressed: () {
                                _initializeGame();
                              },
                              icon: const Icon(Icons.play_arrow_rounded, size: 20),
                              label: const Text(
                                'Restart',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.subject.color,
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Actual Keyboard
                      Expanded(
                        child: Keyboard(
                          onLetterSelected: _guessLetter,
                          usedLetters: _usedLetters,
                          subjectColor: widget.subject.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWordLine(List<String> letters) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letters.map((letter) {
          double boxWidth = 35.0;
          double boxHeight = 45.0;
          double fontSize = 24.0;
          
          if (letters.length > 6) {
            boxWidth = 30.0;
            boxHeight = 40.0;
            fontSize = 20.0;
          }
          
          return Container(
            width: boxWidth,
            height: boxHeight,
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
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
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
        double buttonSize = (constraints.maxWidth - 20) / 10;
        buttonSize = buttonSize.clamp(25.0, 38.0);
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: letters.asMap().entries.map((entry) {
            List<String> row = entry.value;
            
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((letter) {
                  final isUsed = usedLetters.contains(letter);
                  
                  double horizontalPadding = 1.5;
                  
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Material(
                      color: isUsed ? Colors.grey.shade300 : subjectColor,
                      borderRadius: BorderRadius.circular(6),
                      child: InkWell(
                        onTap: isUsed ? null : () => onLetterSelected(letter),
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          width: buttonSize * 0.9,
                          height: buttonSize * 0.9,
                          alignment: Alignment.center,
                          child: Text(
                            letter,
                            style: TextStyle(
                              fontSize: buttonSize * 0.35,
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