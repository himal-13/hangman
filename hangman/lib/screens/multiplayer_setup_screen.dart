import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_setting.dart';
import '../components/coin_dialogs.dart';
import '../models/player.dart';
import 'versus_word_entry_screen.dart';
import 'versus_1v1_game_screen.dart';

enum GameMode { alternating, simultaneous }

class MultiplayerSetupScreen extends StatefulWidget {
  const MultiplayerSetupScreen({super.key});

  @override
  State<MultiplayerSetupScreen> createState() => _MultiplayerSetupScreenState();
}

class _MultiplayerSetupScreenState extends State<MultiplayerSetupScreen> {
  GameMode _selectedMode = GameMode.alternating;
  int _selectedRounds = 3;
  int _numPlayers = 2;

  final List<TextEditingController> _controllers = [];
  final List<Color> _playerColors = [
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();
    _updateControllers();
  }

  void _updateControllers() {
    // Determine how many controllers we need based on mode and numPlayers
    int requiredControllers = _selectedMode == GameMode.alternating ? 2 : _numPlayers;
    
    while (_controllers.length < requiredControllers) {
      _controllers.add(TextEditingController(text: 'Player ${_controllers.length + 1}'));
    }
    while (_controllers.length > requiredControllers) {
      _controllers.last.dispose();
      _controllers.removeLast();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  int get _coinCost => _selectedMode == GameMode.alternating ? 20 : 30;

  void _startMultiplayerMode() {
    final settingsProvider = Provider.of<GameSettingsProvider>(context, listen: false);

    if (settingsProvider.coins < _coinCost) {
      CoinDialogs.showNotEnoughCoinsDialog(
        context: context,
        settingsProvider: settingsProvider,
      );
      return;
    }

    settingsProvider.spendCoins(_coinCost);

    List<MultiplayerPlayer> players = [];
    for (int i = 0; i < _controllers.length; i++) {
      players.add(
        MultiplayerPlayer(
          id: i,
          name: _controllers[i].text.trim().isEmpty ? 'Player ${i + 1}' : _controllers[i].text.trim(),
          color: _playerColors[i],
        ),
      );
    }

    if (_selectedMode == GameMode.alternating) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VersusWordEntryScreen(
            playerMaster: players[0],
            playerGuesser: players[1],
            round: 1,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Versus1v1GameScreen(
            players: players,
            totalRounds: _selectedRounds,
          ),
        ),
      );
    }
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
        actions: [
          _buildCoinCounter(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModeSelector(),
              const SizedBox(height: 24),
              _buildInstructionCard(),
              const SizedBox(height: 32),
              
              if (_selectedMode == GameMode.simultaneous) ...[
                _buildPlayerCountSelector(),
                const SizedBox(height: 24),
              ],

              ..._buildPlayerInputs(),

              const SizedBox(height: 32),
              _buildRoundSelector(),
              const SizedBox(height: 48),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            'GAME MODE',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              letterSpacing: 1.2,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _buildModeOption(
                title: 'Alternating',
                icon: Icons.bolt,
                mode: GameMode.alternating,
                color: const Color(0xFFEF4444),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildModeOption(
                title: 'Simultaneous',
                icon: Icons.sports_soccer,
                mode: GameMode.simultaneous,
                color: const Color(0xFF10B981),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModeOption({
    required String title,
    required IconData icon,
    required GameMode mode,
    required Color color,
  }) {
    bool isSelected = _selectedMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = mode;
          _updateControllers();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? color : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerCountSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            'NUMBER OF PLAYERS',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.shade200, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade50,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButton<int>(
            value: _numPlayers,
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(Icons.arrow_drop_down, color: Colors.green.shade700),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            items: [2, 3, 4].map((count) {
              return DropdownMenuItem<int>(
                value: count,
                child: Text('$count Players'),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _numPlayers = value;
                  _updateControllers();
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionCard() {
    bool isAlt = _selectedMode == GameMode.alternating;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isAlt ? Colors.orange.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isAlt ? Colors.orange.shade200 : Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(
            isAlt ? Icons.info_outline : Icons.sports_soccer, 
            color: isAlt ? Colors.orange.shade700 : Colors.green.shade700, 
            size: 28
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              isAlt 
                ? 'One player sets a word and a hint, the other player tries to guess it!' 
                : 'All players compete in the same rounds! Take turns guessing letters. Highest score wins.',
              style: TextStyle(
                color: isAlt ? const Color(0xFF7C2D12) : const Color(0xFF166534),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPlayerInputs() {
    List<Widget> inputs = [];
    for (int i = 0; i < _controllers.length; i++) {
      inputs.add(
        _buildPlayerInput(
          label: 'PLAYER ${i + 1}',
          controller: _controllers[i],
          color: _playerColors[i],
          icon: Icons.person,
        )
      );
      if (i < _controllers.length - 1) {
        inputs.add(const SizedBox(height: 16));
        if (_selectedMode == GameMode.alternating && i == 0) {
          inputs.add(
            const Center(
              child: Text(
                'VS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF94A3B8),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
          inputs.add(const SizedBox(height: 16));
        }
      }
    }
    return inputs;
  }

  Widget _buildPlayerInput({
    required String label,
    required TextEditingController controller,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.3), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              icon: Icon(icon, color: color),
              border: InputBorder.none,
              hintText: 'Enter name',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoundSelector() {
    bool isAlt = _selectedMode == GameMode.alternating;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            'NUMBER OF ROUNDS',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isAlt ? Colors.orange.shade200 : Colors.green.shade200, 
              width: 2
            ),
            boxShadow: [
              BoxShadow(
                color: isAlt ? Colors.orange.shade50 : Colors.green.shade50,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButton<int>(
            value: _selectedRounds,
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(
              Icons.arrow_drop_down, 
              color: isAlt ? Colors.orange.shade700 : Colors.green.shade700
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            items: List.generate(5, (index) => index + 1).map((rounds) {
              return DropdownMenuItem<int>(
                value: rounds,
                child: Text('$rounds Round${rounds > 1 ? 's' : ''}'),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedRounds = value);
              }
            },
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isAlt ? Colors.orange.shade50 : Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isAlt ? Colors.orange.shade200 : Colors.green.shade200),
          ),
          child: Text(
            'Each round contains:\n• 1 × 2-letter word\n• 1 × 3-letter word\n• 1 × 4-letter word\n• 2 × Hard words (5-7 letters)',
            style: TextStyle(
              fontSize: 12,
              color: isAlt ? const Color(0xFF7C2D12) : const Color(0xFF166534),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _startMultiplayerMode,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E293B),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'CONTINUE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '(🪙 $_coinCost)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.amber.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinCounter() {
    return Consumer<GameSettingsProvider>(
      builder: (context, settings, _) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Text('🪙', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(
              '${settings.coins}',
              style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
