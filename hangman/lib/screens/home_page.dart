import 'package:flutter/material.dart';
import 'package:hangman/services/game_progress.dart';
import 'package:provider/provider.dart';
import 'package:hangman/data/subject.dart';
import '../models/subject.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subject Hangman',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 56,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade400, Colors.purple.shade400],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            tooltip: 'Settings',
          ),
          IconButton(
            icon: const Icon(Icons.refresh, size: 22),
            onPressed: () => _showResetDialog(context),
            tooltip: 'Reset All Progress',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: Consumer<GameProgressProvider>(
          builder: (context, progress, child) {
            final totalEasyWords = SubjectsData.easySubjects.fold<int>(
              0, (sum, s) => sum + s.words.length);
            final totalMediumWords = SubjectsData.mediumSubjects.fold<int>(
              0, (sum, s) => sum + s.words.length);
            final totalHardWords = SubjectsData.hardSubjects.fold<int>(
              0, (sum, s) => sum + s.words.length);
            
            final completedEasy = SubjectsData.easySubjects.fold<int>(
              0, (sum, s) => sum + progress.getCompletedWords(s.id).length);
            final completedMedium = SubjectsData.mediumSubjects.fold<int>(
              0, (sum, s) => sum + progress.getCompletedWords(s.id).length);
            final completedHard = SubjectsData.hardSubjects.fold<int>(
              0, (sum, s) => sum + progress.getCompletedWords(s.id).length);

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Overall Progress Card - Smaller
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade300, Colors.purple.shade300],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildProgressStat(
                          'Easy',
                          completedEasy,
                          totalEasyWords,
                          Colors.green,
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildProgressStat(
                          'Medium',
                          completedMedium,
                          totalMediumWords,
                          Colors.orange,
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildProgressStat(
                          'Hard',
                          completedHard,
                          totalHardWords,
                          Colors.red,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Easy Mode Section
                  _buildDifficultySection(
                    context: context,
                    title: 'Easy Mode',
                    icon: Icons.sentiment_very_satisfied,
                    color: Colors.green,
                    subjects: SubjectsData.easySubjects,
                    progress: progress,
                  ),
                  
                  // Medium Mode Section
                  _buildDifficultySection(
                    context: context,
                    title: 'Medium Mode',
                    icon: Icons.sentiment_neutral,
                    color: Colors.orange,
                    subjects: SubjectsData.mediumSubjects,
                    progress: progress,
                  ),
                  
                  // Hard Mode Section
                  _buildDifficultySection(
                    context: context,
                    title: 'Hard Mode',
                    icon: Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                    subjects: SubjectsData.hardSubjects,
                    progress: progress,
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressStat(String label, int completed, int total, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$completed/$total',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultySection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required List<Subject> subjects,
    required GameProgressProvider progress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 subjects per row
            childAspectRatio: 0.9, // Smaller, more compact cards
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return SubjectCard(
              subject: subject,
              progress: progress.getProgressPercentage(
                subject.id, 
                subject.words.length
              ),
              completedCount: progress.getCompletedWords(subject.id).length,
              isCompleted: progress.isSubjectCompleted(
                subject.id, 
                subject.words.length
              ),
              difficultyColor: color,
            );
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset All Progress', style: TextStyle(fontSize: 18)),
          content: const Text('Are you sure you want to reset all game progress?', style: TextStyle(fontSize: 14)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(fontSize: 14)),
            ),
            TextButton(
              onPressed: () {
                Provider.of<GameProgressProvider>(context, listen: false)
                    .resetAllProgress();
                Navigator.pop(context);
              },
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final double progress;
  final int completedCount;
  final bool isCompleted;
  final Color difficultyColor;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.progress,
    required this.completedCount,
    required this.isCompleted,
    required this.difficultyColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isCompleted ? null : () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(subject: subject),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isCompleted
                ? [Colors.grey.shade400, Colors.grey.shade600]
                : [
                    subject.color.withOpacity(0.8),
                    subject.color,
                  ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: (isCompleted ? Colors.grey : difficultyColor).withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subject.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subject.name,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$completedCount/${subject.words.length}',
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isCompleted)
              const Positioned(
                top: 2,
                right: 2,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}