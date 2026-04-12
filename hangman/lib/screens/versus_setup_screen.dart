import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_setting.dart';
import '../components/coin_dialogs.dart';
import '../models/player.dart';
import 'versus_word_entry_screen.dart';

class VersusSetupScreen extends StatefulWidget {
  const VersusSetupScreen({super.key});

  @override
  State<VersusSetupScreen> createState() => _VersusSetupScreenState();
}

class _VersusSetupScreenState extends State<VersusSetupScreen> {
  final TextEditingController _p1Controller = TextEditingController(text: 'Player 1');
  final TextEditingController _p2Controller = TextEditingController(text: 'Player 2');

  @override
  void dispose() {
    _p1Controller.dispose();
    _p2Controller.dispose();
    super.dispose();
  }

  void _startVersusMode() {
    final settingsProvider = Provider.of<GameSettingsProvider>(context, listen: false);

    if (settingsProvider.coins < 20) {
      CoinDialogs.showNotEnoughCoinsDialog(
        context: context,
        settingsProvider: settingsProvider,
        // No special action after ad, they can just click CONTINUE again
      );
      return;
    }

    // Deduct coins
    settingsProvider.spendCoins(20);

    final player1 = MultiplayerPlayer(
      id: 0,
      name: _p1Controller.text.trim().isEmpty ? 'Player 1' : _p1Controller.text.trim(),
      color: Colors.blue,
    );
    final player2 = MultiplayerPlayer(
      id: 1,
      name: _p2Controller.text.trim().isEmpty ? 'Player 2' : _p2Controller.text.trim(),
      color: Colors.purple,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VersusWordEntryScreen(
          playerMaster: player1,
          playerGuesser: player2,
          round: 1,
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
          'VERSUS MODE',
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
              _buildInstructionCard(),
              const SizedBox(height: 32),
              _buildPlayerInput(
                label: 'PLAYER 1',
                controller: _p1Controller,
                color: Colors.blue,
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              _buildPlayerInput(
                label: 'PLAYER 2',
                controller: _p2Controller,
                color: Colors.purple,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 48),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange.shade700, size: 28),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'One player will set a word and a hint, then the other player will try to guess it!',
              style: TextStyle(
                color: Color(0xFF7C2D12),
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

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _startVersusMode,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E293B),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CONTINUE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '(🪙 20)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.amber,
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
