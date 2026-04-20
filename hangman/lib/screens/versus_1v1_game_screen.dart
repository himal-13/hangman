import 'package:flutter/material.dart';
import '../models/player.dart';
import '../components/keyboard_widget.dart';
import '../components/hangman_drawing.dart';
import '../audio/audio_manager.dart';
import 'versus_1v1_result_screen.dart';

class Versus1v1GameScreen extends StatefulWidget {
  final List<MultiplayerPlayer> players;
  final int totalRounds;

  const Versus1v1GameScreen({
    super.key,
    required this.players,
    required this.totalRounds,
  });

  @override
  State<Versus1v1GameScreen> createState() => _Versus1v1GameScreenState();
}

class _Versus1v1GameScreenState extends State<Versus1v1GameScreen> {
  int _currentRound = 1;
  int _currentWordIndex = 0;
  late List<String> _roundWords;
  late Set<String> _guessedLetters;
  late int _wrongAttempts;
  final int _maxAttempts = 6;
  bool _isGameOver = false;
  bool _isWordGuessed = false;
  MultiplayerPlayer? _currentPlayer;

  // Track words found by each player
  late Map<int, int> _playerWordsFound;

  @override
  void initState() {
    super.initState();
    _playerWordsFound = {for (var p in widget.players) p.id: 0};
    _initializeRound();
  }

  void _initializeRound() {
    _roundWords = _getWordsForRound(_currentRound);
    _currentWordIndex = 0;
    _guessedLetters = {};
    _wrongAttempts = 0;
    _isGameOver = false;
    _isWordGuessed = false;
    _currentPlayer = widget.players.first; // Start with the first player
  }

  List<String> _getWordsForRound(int round) {
    // Define word sets for each round based on the requirements
    final wordSets = [
      // Round 1
      ['AT', 'CAT', 'BIRD', 'FISH', 'HORSE'],
      // Round 2
      ['UP', 'DOG', 'TREE', 'RAIN', 'CLOUD'],
      // Round 3
      ['ON', 'SUN', 'ROAD', 'SNOW', 'WIND'],
      // Round 4
      ['IN', 'EGG', 'BALL', 'FIRE', 'WATER'],
      // Round 5
      ['IT', 'MILK', 'DOOR', 'HOUSE', 'PLANE'],
    ];

    return wordSets[(round - 1) % wordSets.length];
  }

  void _guessLetter(String letter) {
    if (_isGameOver || _isWordGuessed || _guessedLetters.contains(letter)) return;

    setState(() {
      _guessedLetters.add(letter);
      final currentWord = _roundWords[_currentWordIndex];

      if (currentWord.toUpperCase().contains(letter)) {
        AudioManager.playCorrect();
        _isWordGuessed = currentWord.toUpperCase().split('').every((l) => _guessedLetters.contains(l));
        if (_isWordGuessed) {
          // Award points and track words found
          _currentPlayer!.score++;
          _playerWordsFound[_currentPlayer!.id] = (_playerWordsFound[_currentPlayer!.id] ?? 0) + 1;
          _showWordCompletedDialog();
        }
      } else {
        _wrongAttempts++;
        AudioManager.playWrong();
        if (_wrongAttempts >= _maxAttempts) {
          _isGameOver = true;
          _showWordFailedDialog();
        }
      }
    });
  }

  void _showWordCompletedDialog() {
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
                Icons.check_circle,
                color: Colors.green,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                '${_currentPlayer!.name} found the word!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _currentPlayer!.color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Word: ${_roundWords[_currentWordIndex]}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentPlayer!.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _nextWord();
                  },
                  child: const Text('NEXT WORD', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWordFailedDialog() {
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
                Icons.cancel,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Word not found!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Correct word: ${_roundWords[_currentWordIndex]}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _nextWord();
                  },
                  child: const Text('NEXT WORD', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextWord() {
    if (_currentWordIndex < _roundWords.length - 1) {
      // Next word in the same round
      setState(() {
        _currentWordIndex++;
        _guessedLetters = {};
        _wrongAttempts = 0;
        _isGameOver = false;
        _isWordGuessed = false;
        // Switch player for next word
        int currentIndex = widget.players.indexOf(_currentPlayer!);
        int nextIndex = (currentIndex + 1) % widget.players.length;
        _currentPlayer = widget.players[nextIndex];
      });
    } else {
      // Round completed
      _showRoundCompletedDialog();
    }
  }

  void _showRoundCompletedDialog() {
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
                Icons.flag,
                color: Colors.orange,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Round $_currentRound Completed!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 16),
              _buildRoundScoreSummary(),
              const SizedBox(height: 24),
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
                    Navigator.pop(context);
                    if (_currentRound < widget.totalRounds) {
                      _nextRound();
                    } else {
                      _showFinalResults();
                    }
                  },
                  child: Text(
                    _currentRound < widget.totalRounds ? 'NEXT ROUND' : 'FINAL RESULTS',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundScoreSummary() {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: widget.players.map((p) => _buildPlayerRoundScore(p)).toList(),
        ),
      ],
    );
  }

  Widget _buildPlayerRoundScore(MultiplayerPlayer player) {
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
        Text(
          '${player.score} pts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: player.color,
          ),
        ),
      ],
    );
  }

  void _nextRound() {
    setState(() {
      _currentRound++;
      _initializeRound();
    });
  }

  void _showFinalResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Versus1v1ResultScreen(
          players: widget.players,
          playerWordsFound: _playerWordsFound,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = _roundWords[_currentWordIndex];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'ROUND $_currentRound - WORD ${_currentWordIndex + 1}/${_roundWords.length}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildScoreBoard(),
            _buildCurrentPlayerIndicator(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: HangmanDrawing(
                  wrongAttempts: _wrongAttempts,
                  maxAttempts: _maxAttempts,
                  subjectColor: _currentPlayer!.color,
                ),
              ),
            ),
            _buildWordDisplay(currentWord),
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
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: widget.players.map((p) {
          int index = widget.players.indexOf(p);
          Widget item = _buildScoreItem(p);
          if (index < widget.players.length - 1) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                item,
                const SizedBox(width: 8),
                const Text('VS', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey)),
                const SizedBox(width: 8),
              ],
            );
          }
          return item;
        }).toList(),
      ),
    );
  }

  Widget _buildScoreItem(MultiplayerPlayer player) {
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
            'SCORE: ${player.score}',
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

  Widget _buildCurrentPlayerIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      color: _currentPlayer!.color.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, color: _currentPlayer!.color),
          const SizedBox(width: 8),
          Text(
            '${_currentPlayer!.name}\'s Turn',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _currentPlayer!.color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordDisplay(String word) {
    List<String> displayWord = word.split('').map((l) => _guessedLetters.contains(l) ? l : '_').toList();
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
        color: isRevealed ? _currentPlayer!.color : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isRevealed ? _currentPlayer!.color : Colors.grey.shade300,
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
        subjectColor: _currentPlayer!.color,
        useFlame: true,
      ),
    );
  }
}