import 'package:flutter/material.dart';
import 'package:hangman/wordle/screens/wordle_game_screen.dart';
import 'package:hangman/services/wordle_progress.dart';
import 'package:hangman/wordle/data/wordle_level_data.dart';
import 'package:hangman/wordsearch/screens/subject_selection_word_search.dart';
import 'home_page.dart';
import 'multiplayer_setup_screen.dart';
import 'settings_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF5EB), // Warm cream top
              Color(0xFFFFF0E6), // Soft warm peach
              Color(0xFFFEF3E8), // Light warm base
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE2D4C8).withOpacity(0.5),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: Color(0xFF8B6B4D),
                            size: 22,
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
             // Menu Buttons Section
                Expanded(
                  flex: 3,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildWarmMenuButton(
                        context,
                        title: 'Hangman',
                        subtitle: 'Classic word guessing game',
                        icon: Icons.games,
                        color: const Color(0xFFE8925C),
                        lightColor: const Color(0xFFFDE8DD),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                      _buildWarmMenuButton(
                        context,
                        title: 'Word Search',
                        subtitle: 'Find hidden words in the grid',
                        icon: Icons.grid_on,
                        color: const Color(0xFF8FB3A5),
                        lightColor: const Color(0xFFE8F0EC),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const WordSearchSubjectSelectionScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                      _buildWarmMenuButton(
                        context,
                        title: 'Word Guess',
                        subtitle: 'Continue the latest unlocked level',
                        icon: Icons.spellcheck,
                        color: const Color(0xFFD4A373),
                        lightColor: const Color(0xFFFDF3E8),
                        onTap: () {
                          final navigator = Navigator.of(context);
                          WordleProgress.getLatestUnlockedLevel().then((levelNumber) {
                            final level = WordleLevelData.levels[levelNumber - 1];
                            navigator.push(
                              MaterialPageRoute(
                                builder: (_) => WordleGameScreen(level: level),
                              ),
                            );
                          });
                        },
                      ),
                      const SizedBox(height: 14),
                      _buildWarmMenuButton(
                        context,
                        title: 'Multiplayer',
                        subtitle: 'Challenge your friends locally',
                        icon: Icons.people,
                        color: const Color(0xFFC9A87C),
                        lightColor: const Color(0xFFFBF5EB),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MultiplayerSetupScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWarmMenuButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color lightColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF5C4033),
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9B7B62),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: color,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}