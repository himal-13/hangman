import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/wordle_game_state.dart';
import '../widgets/wordle_grid.dart';
import '../widgets/wordle_keyboard.dart';

class WordleGameScreen extends StatelessWidget {
  final int level;

  const WordleGameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WordleGameState(level: level),
      child: const _WordleGameScreenContent(),
    );
  }
}

class _WordleGameScreenContent extends StatelessWidget {
  const _WordleGameScreenContent();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WordleGameState>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.isGameOver) {
        if (state.isGameWon) {
          _showWinDialog(context, state);
        } else {
          _showLoseDialog(context, state);
        }
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF475569)),
        title: Text(
          'Level ${state.level} (${state.wordLength} Letters)',
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: WordleGrid(state: state),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: WordleKeyboard(state: state),
            ),
          ],
        ),
      ),
    );
  }

  void _showWinDialog(BuildContext context, WordleGameState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('You Won!', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, color: Colors.amber, size: 64),
              const SizedBox(height: 16),
              Text(
                'You guessed the word:\n${state.targetWord}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showLoseDialog(BuildContext context, WordleGameState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Game Over', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sentiment_very_dissatisfied, color: Colors.orange, size: 64),
              const SizedBox(height: 16),
              Text(
                'The word was:\n${state.targetWord}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                state.reset();
              },
              child: const Text('Try Again'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Quit', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
