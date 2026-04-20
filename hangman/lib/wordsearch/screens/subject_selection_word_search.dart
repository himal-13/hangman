import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hangman/services/game_progress.dart';
import 'package:hangman/services/game_setting.dart';
import '../data/word_search_data.dart';
import '../models/word_search_subject.dart';
import 'word_search_game.dart';

class WordSearchSubjectSelectionScreen extends StatelessWidget {
  const WordSearchSubjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          'Word Search Subjects',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        actions: [
          _buildCoinCounter(),
        ],
      ),
      body: Consumer<GameProgressProvider>(
        builder: (context, progress, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildDifficultySection(
                  context,
                  'Easy',
                  'Simple words and small grids',
                  Icons.emoji_emotions_outlined,
                  Colors.green,
                  WordSearchData.easySubjects,
                  progress,
                ),
                _buildDifficultySection(
                  context,
                  'Medium',
                  'Challenging words and larger grids',
                  Icons.emoji_objects_outlined,
                  Colors.orange,
                  WordSearchData.mediumSubjects,
                  progress,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoinCounter() {
    return Consumer<GameSettingsProvider>(
      builder: (context, settings, _) => Container(
        margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
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

  Widget _buildDifficultySection(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<WordSearchSubject> subjects,
    GameProgressProvider progress,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            int completedLevels = 0;
            for (int i = 0; i < subject.levels.length; i++) {
              if (progress.isWordCompleted(subject.id, 'level_$i')) {
                completedLevels++;
              }
            }
            final isCompleted = completedLevels >= subject.levels.length;

            return _WordSearchSubjectCard(
              subject: subject,
              completedCount: completedLevels,
              isCompleted: isCompleted,
              difficultyColor: color,
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _WordSearchSubjectCard extends StatelessWidget {
  final WordSearchSubject subject;
  final int completedCount;
  final bool isCompleted;
  final Color difficultyColor;

  const _WordSearchSubjectCard({
    required this.subject,
    required this.completedCount,
    required this.isCompleted,
    required this.difficultyColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onSubjectTap(context, subject),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isCompleted
                ? [Colors.grey.shade400, Colors.grey.shade600]
                : [subject.color.withOpacity(0.8), subject.color],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (isCompleted ? Colors.grey : difficultyColor).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                    child: Center(child: Text(subject.icon, style: const TextStyle(fontSize: 24))),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subject.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$completedCount/${subject.levels.length} Levels',
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
            ),
            if (isCompleted)
              const Positioned(top: 12, right: 12, child: Icon(Icons.check_circle, color: Colors.white, size: 20)),
          ],
        ),
      ),
    );
  }

  void _onSubjectTap(BuildContext context, WordSearchSubject subject) {
    final progress = Provider.of<GameProgressProvider>(context, listen: false);
    
    int currentLevelIndex = 0;
    for (int i = 0; i < subject.levels.length; i++) {
      if (progress.isWordCompleted(subject.id, 'level_$i')) {
        currentLevelIndex = i + 1;
      } else {
        currentLevelIndex = i;
        break;
      }
    }
    
    if (currentLevelIndex >= subject.levels.length) {
      currentLevelIndex = subject.levels.length - 1; // Play last level again
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WordSearchGameScreen(
          level: subject.levels[currentLevelIndex],
          levelIndex: currentLevelIndex,
          totalLevels: subject.levels.length,
          subject: subject,
          onLevelComplete: () {
            progress.markWordAsCompleted(subject.id, 'level_$currentLevelIndex');
          },
        ),
      ),
    );
  }
}
