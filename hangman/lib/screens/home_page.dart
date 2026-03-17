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
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
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
            icon: const Icon(Icons.settings),
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
            icon: const Icon(Icons.refresh),
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Choose a Subject',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Consumer<GameProgressProvider>(
              builder: (context, progress, child) {
                final totalCompleted = SubjectsData.subjects.fold<int>(
                  0,
                  (sum, subject) => sum + progress.getCompletedWords(subject.id).length,
                );
                final totalWords = SubjectsData.subjects.fold<int>(
                  0,
                  (sum, subject) => sum + subject.words.length,
                );
                
                return Text(
                  'Overall Progress: $totalCompleted/$totalWords words',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: SubjectsData.subjects.length,
                itemBuilder: (context, index) {
                  final subject = SubjectsData.subjects[index];
                  return Consumer<GameProgressProvider>(
                    builder: (context, progress, child) {
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
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset All Progress'),
          content: const Text('Are you sure you want to reset all game progress?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<GameProgressProvider>(context, listen: false)
                    .resetAllProgress();
                Navigator.pop(context);
              },
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.red),
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

  const SubjectCard({
    super.key,
    required this.subject,
    required this.progress,
    required this.completedCount,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isCompleted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(subject: subject),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isCompleted
                ? [Colors.grey.shade400, Colors.grey.shade600]
                : [
                    subject.color.withOpacity(0.7),
                    subject.color,
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isCompleted 
                  ? Colors.grey.withOpacity(0.3)
                  : subject.color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    subject.icon,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subject.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Text(
                  //   '$completedCount/${subject.words.length} words',
                  //   style: const TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.white70,
                  //   ),
                  // ),
                  // Progress bar
                  // Container(
                  //   width: 100,
                  //   height: 4,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.3),
                  //     borderRadius: BorderRadius.circular(2),
                  //   ),
                  //   child: FractionallySizedBox(
                  //     alignment: Alignment.centerLeft,
                  //     widthFactor: progress,
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(2),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            if (isCompleted)
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }
}