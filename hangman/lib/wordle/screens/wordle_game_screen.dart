import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hangman/audio/audio_manager.dart';
import 'package:hangman/services/wordle_progress.dart';
import '../data/wordle_level_data.dart';
import '../models/wordle_multi_game_state.dart';

class WordleGameScreen extends StatelessWidget {
  final WordleLevel level;

  const WordleGameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WordleMultiGameState(level: level),
      child: const _GameContent(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _GameContent extends StatefulWidget {
  const _GameContent();
  @override
  State<_GameContent> createState() => _GameContentState();
}

class _GameContentState extends State<_GameContent> {
  bool _dialogShown = false;

  // Accent color matching other game modes
  static const Color _accentColor = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WordleMultiGameState>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.isLevelComplete && !_dialogShown) {
        _dialogShown = true;
        AudioManager.playLevelComplete();
        WordleProgress.unlockNextLevel(state.level.levelNumber);
        _showWinDialog(context, state);
      }
    });

    final solved = state.solvedWords.where((s) => s).length;
    final total = state.level.words.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Level ${state.level.levelNumber} • ${state.level.theme}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: _accentColor,
        foregroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '$solved / $total',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _accentColor.withOpacity(0.08),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              // Word rows area
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: _buildWordRows(state),
                  ),
                ),
              ),

              // Letter bank
              _buildLetterBank(state),

              // Action buttons
              _buildActions(state),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // ── Word Rows ─────────────────────────────────────────────────────────────

  Widget _buildWordRows(WordleMultiGameState state) {
    return Column(
      children: List.generate(state.level.words.length, (i) {
        final word = state.level.words[i];
        final isSolved = state.solvedWords[i];
        final isSelected = !isSolved && state.selectedWordIndex == i;
        final input = isSelected ? state.currentInput : '';
        final isWrong = isSelected && state.lastSubmitWrong;

        return GestureDetector(
          onTap: () => state.selectWord(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isSolved
                  ? Colors.green.shade50
                  : isWrong
                      ? Colors.red.shade50
                      : isSelected
                          ? _accentColor.withOpacity(0.06)
                          : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSolved
                    ? Colors.green.shade400
                    : isWrong
                        ? Colors.red.shade400
                        : isSelected
                            ? _accentColor
                            : Colors.grey.shade200,
                width: isWrong ? 2.5 : isSelected ? 2 : 1.5,
              ),
            ),
            child: Row(
              children: [
                // Word index badge
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isSolved
                        ? Colors.green.shade400
                        : isWrong
                            ? Colors.red.shade400
                            : isSelected
                                ? _accentColor
                                : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: isSolved
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : isWrong
                          ? const Icon(Icons.close, color: Colors.white, size: 16)
                          : Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                ),
                const SizedBox(width: 10),
                // Letter boxes
                Expanded(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(word.length, (j) {
                      String letter = '';
                      if (isSolved) {
                        letter = word[j];
                      } else if (j < input.length) {
                        letter = input[j];
                      }
                      return _buildBox(
                        letter: letter,
                        isSolved: isSolved,
                        isSelected: isSelected,
                        hasCursor: isSelected && j == input.length && !isSolved,
                        isWrong: isWrong,
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 6),
                // Word length hint
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${word.length}',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBox({
    required String letter,
    required bool isSolved,
    required bool isSelected,
    required bool hasCursor,
    bool isWrong = false,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 36,
      height: 40,
      decoration: BoxDecoration(
        color: isSolved
            ? Colors.green.shade400
            : isWrong
                ? Colors.red.shade50
                : letter.isNotEmpty
                    ? _accentColor.withOpacity(0.12)
                    : hasCursor
                        ? _accentColor.withOpacity(0.06)
                        : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSolved
              ? Colors.green.shade500
              : isWrong
                  ? Colors.red.shade400
                  : hasCursor
                      ? _accentColor
                      : isSelected
                          ? _accentColor.withOpacity(0.4)
                          : Colors.grey.shade300,
          width: isWrong ? 2.5 : hasCursor ? 2 : 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: hasCursor && letter.isEmpty
          ? Container(
              width: 2,
              height: 20,
              color: _accentColor,
            )
          : Text(
              letter,
              style: TextStyle(
                color: isSolved
                    ? Colors.white
                    : isWrong
                        ? Colors.red.shade700
                        : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
    );
  }

  // ── Letter Bank ───────────────────────────────────────────────────────────

  Widget _buildLetterBank(WordleMultiGameState state) {
    final letters = state.allLetters;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: letters.map((letter) {
          final count = state.getRemainingCount(letter);
          final isAvailable = count > 0;
          return GestureDetector(
            onTap: isAvailable ? () => state.addLetter(letter) : null,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isAvailable ? 1.0 : 0.25,
              child: IgnorePointer(
                ignoring: !isAvailable,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? _accentColor
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: isAvailable
                            ? [
                                BoxShadow(
                                  color: _accentColor.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    // Count badge
                    if (isAvailable)
                      Positioned(
                        top: -5,
                        right: -5,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: count > 1
                                ? Colors.amber.shade700
                                : Colors.deepOrange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Action Buttons ────────────────────────────────────────────────────────

  Widget _buildActions(WordleMultiGameState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: state.removeLetter,
              icon: const Icon(Icons.backspace_outlined, size: 18),
              label: const Text(
                'DELETE',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.grey.shade700,
                elevation: 1,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
                      onPressed: () {
                final ok = state.submitWord();
                if (ok) {
                  AudioManager.playCorrect();
                }
                if (!ok && state.lastSubmitWrong) {
                  AudioManager.playWrong();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Not quite right – try again!'),
                      backgroundColor: Colors.red.shade600,
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
              label: const Text(
                'SUBMIT',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentColor,
                foregroundColor: Colors.white,
                elevation: 2,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Win Dialog ────────────────────────────────────────────────────────────

  void _showWinDialog(BuildContext context, WordleMultiGameState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
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
              // Trophy icon
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
                '🎉 LEVEL COMPLETE!',
                style: TextStyle(
                  fontSize: 26,
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

              // Words found
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'You found all ${state.level.words.length} words!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Solved words chips
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 6,
                children: state.level.words
                    .map((w) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            w,
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ))
                    .toList(),
              ),

              const SizedBox(height: 20),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {
                            _dialogShown = false;
                            Navigator.of(context).pop();
                            state.reset();
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh_rounded,
                                    size: 20, color: Colors.green.shade700),
                                const SizedBox(width: 5),
                                Text(
                                  'REPLAY',
                                  style: TextStyle(
                                    color: Colors.green.shade700,
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Material(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.home_rounded,
                                    size: 20, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  'MENU',
                                  style: TextStyle(
                                    color: Colors.white,
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
                  ),
                ],
              ),

              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
