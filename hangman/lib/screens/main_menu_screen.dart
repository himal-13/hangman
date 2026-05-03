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
                // App Title
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Text(
                        'HANGMAN',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF5C4033),
                          letterSpacing: 4,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'WORD ADVENTURE',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8B6B4D),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                // Menu Buttons Section - 2 per row
                Expanded(
                  flex: 3,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 1.1,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildWarmMenuButton(
                            context,
                            title: 'Hangman',
                            subtitle: '',
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
                          _buildWarmMenuButton(
                            context,
                            title: 'Word Search',
                            subtitle: '',
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
                          _buildWarmMenuButton(
                            context,
                            title: 'Wordoku',
                            subtitle: '',
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
                          _buildWarmMenuButton(
                            context,
                            title: 'Multiplayer',
                            subtitle: '',
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
                        ],
                      ),
                    ),
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
            padding: const EdgeInsets.all(12),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5C4033),
                    letterSpacing: -0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9B7B62),
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}