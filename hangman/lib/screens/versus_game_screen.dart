import 'package:flutter/material.dart';
import '../models/player.dart';
import '../components/keyboard_widget.dart';
import '../components/hangman_drawing.dart';
import '../audio/audio_manager.dart';
import 'versus_word_entry_screen.dart';
import 'main_menu_screen.dart';

class VersusGameScreen extends StatefulWidget {
  final MultiplayerPlayer playerMaster;
  final MultiplayerPlayer playerGuesser;
  final String word;
  final String hint;
  final int round;

  const VersusGameScreen({
    super.key,
    required this.playerMaster,
    required this.playerGuesser,
    required this.word,
    required this.hint,
    required this.round,
  });

  @override
  State<VersusGameScreen> createState() => _VersusGameScreenState();
}

class _VersusGameScreenState extends State<VersusGameScreen> {
  late Set<String> _guessedLetters;
  late int _wrongAttempts;
  final int _maxAttempts = 6;
  bool _isGameOver = false;
  bool _isWordGuessed = false;

  @override
  void initState() {
    super.initState();
    _guessedLetters = {};
    _wrongAttempts = 0;
  }

  void _guessLetter(String letter) {
    if (_isGameOver || _isWordGuessed || _guessedLetters.contains(letter)) return;

    setState(() {
      _guessedLetters.add(letter);
      if (widget.word.toUpperCase().contains(letter)) {
        AudioManager.playCorrect();
        _isWordGuessed = widget.word.toUpperCase().split('').every((l) => _guessedLetters.contains(l));
        if (_isWordGuessed) {
          widget.playerGuesser.score++;
          _showResultDialog(true);
        }
      } else {
        _wrongAttempts++;
        AudioManager.playWrong();
        if (_wrongAttempts >= _maxAttempts) {
          _isGameOver = true;
          _showResultDialog(false);
        }
      }
    });
  }

  void _showHint() {
    if (widget.hint.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hint provided for this word!')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber.shade700),
            const SizedBox(width: 10),
            const Text('HINT'),
          ],
        ),
        content: Text(
          widget.hint,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('GOT IT'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _showResultDialog(bool won) {
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
              Icon(
                won ? Icons.emoji_events : Icons.sentiment_very_dissatisfied,
                color: won ? Colors.amber : Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                won ? 'Word Found!' : 'Game Over',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: won ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                won 
                  ? '${widget.playerGuesser.name} successfully guessed the word!'
                  : '${widget.playerGuesser.name} couldn\'t find the word.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Text(
                'Correct word: ${widget.word}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                'Next: Roles will swap!',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Pop dialog
                    _swapRoles();
                  },
                  child: const Text('NEXT ROUND', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              TextButton(
                onPressed: () {
                   Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenuScreen()),
                      (route) => false,
                    );
                },
                child: const Text('Back to Main Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _swapRoles() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VersusWordEntryScreen(
          playerMaster: widget.playerGuesser,
          playerGuesser: widget.playerMaster,
          round: widget.round + 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'ROUND ${widget.round}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline, color: Colors.amber),
            onPressed: _showHint,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildScoreBoard(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: HangmanDrawing(
                  wrongAttempts: _wrongAttempts,
                  maxAttempts: _maxAttempts,
                  subjectColor: widget.playerGuesser.color,
                ),
              ),
            ),
            _buildWordDisplay(),
            const SizedBox(height: 30),
            _buildKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreBoard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildScoreItem(widget.playerMaster, isMaster: true),
          const Text('VS', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey)),
          _buildScoreItem(widget.playerGuesser, isMaster: false),
        ],
      ),
    );
  }

  Widget _buildScoreItem(MultiplayerPlayer player, {required bool isMaster}) {
    return Column(
      children: [
        Text(
          player.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: player.color,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: player.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isMaster ? 'MASTER' : 'SCORE: ${player.score}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: player.color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWordDisplay() {
    List<String> displayWord = widget.word.split('').map((l) => _guessedLetters.contains(l) ? l : '_').toList();
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: displayWord.map((letter) => _buildLetterBox(letter)).toList(),
    );
  }

  Widget _buildLetterBox(String letter) {
    bool isRevealed = letter != '_';
    return Container(
      width: 35,
      height: 45,
      decoration: BoxDecoration(
        color: isRevealed ? widget.playerGuesser.color : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isRevealed ? widget.playerGuesser.color : Colors.grey.shade300,
          width: 2,
        ),
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

  Widget _buildKeyboard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      height: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Keyboard(
        onLetterSelected: _guessLetter,
        usedLetters: _guessedLetters,
        subjectColor: widget.playerGuesser.color,
        useFlame: true,
      ),
    );
  }
}
