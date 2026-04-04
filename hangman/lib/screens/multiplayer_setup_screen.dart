import 'package:flutter/material.dart';
import 'multiplayer_game_screen.dart';
import '../models/player.dart';
import '../services/ad_service.dart';

class MultiplayerSetupScreen extends StatefulWidget {
  const MultiplayerSetupScreen({super.key});

  @override
  State<MultiplayerSetupScreen> createState() => _MultiplayerSetupScreenState();
}

class _MultiplayerSetupScreenState extends State<MultiplayerSetupScreen> {
  int _playerCount = 2;
  String _difficulty = 'Easy';
  final List<TextEditingController> _nameControllers = [];
  bool _isAdWatched = false;
  bool _isAdLoading = false;

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
    AdMobService.loadRewardedAd();
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'MULTIPLAYER',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22, letterSpacing: 1),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Players Section
            _buildSectionCard(
              title: 'PLAYERS',
              icon: Icons.people,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [2, 3, 4].map((count) {
                      final isSelected = _playerCount == count;
                      return _buildOptionChip(
                        label: '${count}P',
                        isSelected: isSelected,
                        selectedColor: Colors.orange,
                        onTap: () => setState(() => _playerCount = count),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Difficulty Section
            _buildSectionCard(
              title: 'DIFFICULTY',
              icon: Icons.speed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Easy', 'Medium', 'Hard'].map((diff) {
                  final isSelected = _difficulty == diff;
                  Color diffColor = Colors.green;
                  if (diff == 'Medium') diffColor = Colors.orange;
                  if (diff == 'Hard') diffColor = Colors.red;
                  return _buildOptionChip(
                    label: diff,
                    isSelected: isSelected,
                    selectedColor: diffColor,
                    onTap: () => setState(() => _difficulty = diff),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Player Names Section
            _buildSectionCard(
              title: 'PLAYER NAMES',
              icon: Icons.edit,
              child: Column(
                children: List.generate(_playerCount, (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _playerColors[index].withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _playerColors[index].withOpacity(0.3), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: _playerColors[index],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _nameControllers[index],
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Player ${index + 1} name',
                              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Ad Section
            if (!_isAdWatched) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade50, Colors.orange.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.video_library, color: Colors.orange.shade700, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Watch Ad to Unlock',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'One short ad unlocks full multiplayer experience',
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton.icon(
                        onPressed: _isAdLoading ? null : _showAd,
                        icon: _isAdLoading 
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.play_arrow),
                        label: Text(_isAdLoading ? 'LOADING...' : 'WATCH AD'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            
            // Start Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isAdWatched ? _startGame : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isAdWatched ? Colors.orange : Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  elevation: _isAdWatched ? 2 : 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  'START GAME',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: _isAdWatched ? Colors.white : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionChip({
    required String label,
    required bool isSelected,
    required Color selectedColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? selectedColor : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Future<void> _showAd() async {
    setState(() => _isAdLoading = true);
    await AdMobService.showRewardedAd(
      onRewarded: () {
        setState(() {
          _isAdWatched = true;
          _isAdLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Multiplayer unlocked!'), duration: Duration(seconds: 2)),
        );
      },
      onFailed: () {
        setState(() => _isAdLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load ad. Please try again.')),
        );
      },
    );
  }
}