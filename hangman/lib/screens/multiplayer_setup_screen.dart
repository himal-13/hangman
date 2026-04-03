import 'package:flutter/material.dart';
import 'multiplayer_game_screen.dart';
import '../models/player.dart';

class MultiplayerSetupScreen extends StatefulWidget {
  const MultiplayerSetupScreen({super.key});

  @override
  State<MultiplayerSetupScreen> createState() => _MultiplayerSetupScreenState();
}

class _MultiplayerSetupScreenState extends State<MultiplayerSetupScreen> {
  int _playerCount = 2;
  String _difficulty = 'Easy'; // Easy, Medium, Hard
  final List<TextEditingController> _nameControllers = [];
  
  final List<Color> _playerColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameControllers.clear();
    for (int i = 0; i < 4; i++) {
      _nameControllers.add(TextEditingController(text: 'Player ${i + 1}'));
    }
  }

  @override
  void dispose() {
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startGame() {
    List<MultiplayerPlayer> players = [];
    for (int i = 0; i < _playerCount; i++) {
      players.add(
        MultiplayerPlayer(
          id: i,
          name: _nameControllers[i].text.trim().isEmpty ? 'Player ${i + 1}' : _nameControllers[i].text.trim(),
          color: _playerColors[i],
        ),
      );
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MultiplayerGameScreen(
          players: players,
          difficulty: _difficulty,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Multiplayer Setup', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Number of Players',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [2, 3, 4].map((count) {
                final isSelected = _playerCount == count;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text('$count Players', style: TextStyle(color: isSelected ? Colors.white : Colors.black87)),
                    selected: isSelected,
                    selectedColor: Colors.orange,
                    onSelected: (selected) {
                      if (selected) setState(() => _playerCount = count);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            const Text(
              'Difficulty',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['Easy', 'Medium', 'Hard'].map((diff) {
                final isSelected = _difficulty == diff;
                Color diffColor = Colors.green;
                if (diff == 'Medium') diffColor = Colors.orange;
                if (diff == 'Hard') diffColor = Colors.red;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(diff, style: TextStyle(color: isSelected ? Colors.white : Colors.black87)),
                    selected: isSelected,
                    selectedColor: diffColor,
                    onSelected: (selected) {
                      if (selected) setState(() => _difficulty = diff);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            const Text(
              'Player Names',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            ...List.generate(_playerCount, (index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _playerColors[index].withOpacity(0.5), width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: _playerColors[index]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _nameControllers[index],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Player ${index + 1} Name',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _startGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                ),
                child: const Text('START GAME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
