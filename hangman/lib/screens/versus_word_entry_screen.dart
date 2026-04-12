import 'package:flutter/material.dart';
import '../models/player.dart';
import 'versus_game_screen.dart';

class VersusWordEntryScreen extends StatefulWidget {
  final MultiplayerPlayer playerMaster;
  final MultiplayerPlayer playerGuesser;
  final int round;

  const VersusWordEntryScreen({
    super.key,
    required this.playerMaster,
    required this.playerGuesser,
    required this.round,
  });

  @override
  State<VersusWordEntryScreen> createState() => _VersusWordEntryScreenState();
}

class _VersusWordEntryScreenState extends State<VersusWordEntryScreen> {
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _hintController = TextEditingController();
  bool _obscureWord = true;

  @override
  void dispose() {
    _wordController.dispose();
    _hintController.dispose();
    super.dispose();
  }

  void _onReady() {
    String word = _wordController.text.trim().toUpperCase();
    String hint = _hintController.text.trim();

    if (word.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a word!')),
      );
      return;
    }

    if (word.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Word must be at least 2 letters long!')),
      );
      return;
    }

    if (!RegExp(r'^[A-Z]+$').hasMatch(word)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Word must contain only letters!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VersusGameScreen(
          playerMaster: widget.playerMaster,
          playerGuesser: widget.playerGuesser,
          word: word,
          hint: hint,
          round: widget.round,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ROUND ${widget.round}',
          style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildRoleHeader(),
              const SizedBox(height: 40),
              _buildWordInput(),
              const SizedBox(height: 24),
              _buildHintInput(),
              const SizedBox(height: 60),
              _buildStartButton(),
              const SizedBox(height: 20),
              Text(
                'Don\'t let ${widget.playerGuesser.name} see!',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: widget.playerMaster.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.edit, color: widget.playerMaster.color, size: 40),
        ),
        const SizedBox(height: 16),
        Text(
          widget.playerMaster.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: widget.playerMaster.color,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'It\'s your turn to set the word!',
          style: TextStyle(fontSize: 16, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildWordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECRET WORD',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF94A3B8),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _wordController,
            obscureText: _obscureWord,
            textCapitalization: TextCapitalization.characters,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
            decoration: InputDecoration(
              hintText: 'Type word here...',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              suffixIcon: IconButton(
                icon: Icon(_obscureWord ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                onPressed: () => setState(() => _obscureWord = !_obscureWord),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHintInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HINT (OPTIONAL)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF94A3B8),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _hintController,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              hintText: 'Give a clue...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
        onPressed: _onReady,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.playerMaster.color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: widget.playerMaster.color.withOpacity(0.4),
        ),
        child: const Text(
          'READY FOR GUESSING',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
