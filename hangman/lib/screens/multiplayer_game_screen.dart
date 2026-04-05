import 'package:flutter/material.dart';
import '../models/player.dart';
import '../data/multiplayer_words.dart';
import 'multiplayer_result_screen.dart';
import '../components/keyboard_widget.dart';
import '../components/hangman_drawing.dart';
import '../audio/audio_manager.dart';

class MultiplayerGameScreen extends StatefulWidget {
  final List<MultiplayerPlayer> players;
  final String difficulty;

  const MultiplayerGameScreen({
    super.key,
    required this.players,
    required this.difficulty,
  });

  @override
  State<MultiplayerGameScreen> createState() => _MultiplayerGameScreenState();
}

class _MultiplayerGameScreenState extends State<MultiplayerGameScreen> {
  int _currentPlayerIndex = 0;
  bool _isLoading = true;
  
  List<String> _wordsList = [];
  int _currentWordIndex = 0;
  String _currentWord = '';
  Set<String> _guessedLetters = {};
  bool _isSwitchingPlayer = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  @override
  Widget build(BuildContext context) {
    return _buildGameScaffold();
  }

  Widget _buildGameScaffold() {
    if (_isLoading) return const Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));

    MultiplayerPlayer activePlayer = widget.players[_currentPlayerIndex];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          _isSwitchingPlayer ? 'Switching...' : '${activePlayer.name}\'s Turn',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isSwitchingPlayer ? Colors.grey : activePlayer.color,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () async {
            final shouldQuit = await _showQuitDialog();
            if (shouldQuit && mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: activePlayer.color.withOpacity(0.5), width: 6),
          ),
          child: Column(
            children: [
              // Player Status Bar
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.players.map((p) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: _currentPlayerIndex == p.id && !_isSwitchingPlayer ? 20 : 15,
                          backgroundColor: p.color,
                          child: p.isGameOver 
                            ? const Icon(Icons.close, color: Colors.white, size: 20)
                            : Text('${p.maxAttempts - p.wrongAttempts}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${p.name}\n${p.score} pts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: _currentPlayerIndex == p.id && !_isSwitchingPlayer ? FontWeight.bold : FontWeight.normal,
                            color: p.color,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              
              // Hangman Drawing
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: HangmanDrawing(
                    wrongAttempts: activePlayer.wrongAttempts,
                    maxAttempts: activePlayer.maxAttempts, 
                    subjectColor: activePlayer.color,
                  ),
                ),
              ),
        
              // Word Display
              Wrap(
                spacing: 8,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: _currentWordDisplay.map((letter) {
                  return _buildLetterBox(letter, activePlayer.color);
                }).toList(),
              ),
        
              const SizedBox(height: 30),
        
              // Keyboard widget
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    )
                  ],
                ),
                child: _isSwitchingPlayer 
                  ? const Center(
                      child: Text(
                        'Get Ready...',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    )
                  : Keyboard(
                      onLetterSelected: _guessLetter,
                      usedLetters: _guessedLetters,
                      subjectColor: activePlayer.color,
                      useFlame: true,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLetterBox(String letter, Color color) {
    bool isRevealed = letter != '_';
    return Container(
      width: 35,
      height: 45,
      decoration: BoxDecoration(
        color: isRevealed ? color : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isRevealed ? color : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: isRevealed ? [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ] : null,
      ),
      child: Center(
        child: Text(
          isRevealed ? letter : '',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isRevealed ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Future<bool> _showQuitDialog() async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.red.shade700,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              
              // Title
              const Text(
                'Quit Game?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              
              // Message
              Text(
                'Are you sure you want to quit the multiplayer match?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'All progress will be lost!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade400,
                ),
              ),
              const SizedBox(height: 24),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Text(
                        'RESUME',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'QUIT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ) ?? false;
  }

  List<String> get _currentWordDisplay {
    return _currentWord.toUpperCase().split('').map((letter) {
      return _guessedLetters.contains(letter) ? letter : '_';
    }).toList();
  }

  void _guessLetter(String letter) {
    if (_isLoading || _isSwitchingPlayer) return;

    MultiplayerPlayer activePlayer = widget.players[_currentPlayerIndex];
    if (activePlayer.isGameOver) return;
    if (_guessedLetters.contains(letter)) return;

    setState(() {
      _guessedLetters.add(letter);

      if (_currentWord.toUpperCase().contains(letter)) {
        AudioManager.playCorrect();
        
        bool isWordGuessed = _currentWord.toUpperCase().split('').every((l) => _guessedLetters.contains(l));
        if (isWordGuessed) {
          activePlayer.score++;
          _showWordFoundDialog(activePlayer);
        }
      } else {
        activePlayer.wrongAttempts++;
        AudioManager.playWrong();
        _moveToNextPlayer();
      }
    });
  }

  void _showWordFoundDialog(MultiplayerPlayer player) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: player.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.emoji_events, color: player.color, size: 48),
              ),
              const SizedBox(height: 16),
              Text(
                'Word Found!',
                style: TextStyle(
                  color: player.color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${player.name} correctly guessed:',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: player.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: player.color.withOpacity(0.3)),
                ),
                child: Text(
                  _currentWord.toUpperCase(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: player.color,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: player.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _nextWord();
                    });
                  },
                  child: const Text(
                    'NEXT WORD',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextWord() {
    _currentWordIndex++;
    if (_currentWordIndex >= _wordsList.length) {
      _wordsList.shuffle();
      _currentWordIndex = 0;
    }
    _currentWord = _wordsList[_currentWordIndex];
    _guessedLetters.clear();
    
    _moveToNextPlayer();
  }

  void _moveToNextPlayer() {
    // Check if current player is game over
    if (widget.players[_currentPlayerIndex].isGameOver) {
      // Find next player who is not game over
      int nextIndex = (_currentPlayerIndex + 1) % widget.players.length;
      while (widget.players[nextIndex].isGameOver && nextIndex != _currentPlayerIndex) {
        nextIndex = (nextIndex + 1) % widget.players.length;
      }
      
      if (widget.players[nextIndex].isGameOver) {
        _endGame();
        return;
      }
      
      _currentPlayerIndex = nextIndex;
    }
    
    // Check if all players are game over
    if (widget.players.every((p) => p.isGameOver)) {
      _endGame();
      return;
    }

    _isSwitchingPlayer = true;
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isSwitchingPlayer = false;
        
        if (widget.players.every((p) => p.isGameOver)) {
          _endGame();
          return;
        }

        int checkIndex = (_currentPlayerIndex + 1) % widget.players.length;
        while (widget.players[checkIndex].isGameOver && checkIndex != _currentPlayerIndex) {
          checkIndex = (checkIndex + 1) % widget.players.length;
        }
        
        // If we've looped back and everyone is game over, end the game
        if (checkIndex == _currentPlayerIndex && widget.players[checkIndex].isGameOver) {
          _endGame();
          return;
        }
        
        _currentPlayerIndex = checkIndex;
      });
    });
  }

  void _endGame() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MultiplayerResultScreen(
          players: widget.players,
          difficulty: widget.difficulty,
        ),
      ),
    );
  }

  void _initializeGame() {
    _wordsList = List.from(MultiplayerWords.getWordsForDifficulty(widget.difficulty))..shuffle();
    _currentWordIndex = 0;
    _currentWord = _wordsList[_currentWordIndex];

    for (var player in widget.players) {
      player.resetGameStats(6);
    }

    setState(() {
      _isLoading = false;
    });
  }
}