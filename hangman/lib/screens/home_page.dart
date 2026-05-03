import 'package:flutter/material.dart';
import 'package:hangman/services/game_progress.dart';
import 'package:hangman/services/game_setting.dart';
import 'package:provider/provider.dart';
import 'package:hangman/data/subject.dart';
import '../models/subject.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text('Hangman Game', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        actions: [
          _buildCoinCounter(),
        ],
      ),
      body: const SafeArea(child: ClassicModeView()),
    );
  }

  Widget _buildCoinCounter() {
    return Consumer<GameSettingsProvider>(
      builder: (context, settings, _) => Container(
        margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
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

// class DailyCoinClaimCard extends StatelessWidget {
//   const DailyCoinClaimCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<GameSettingsProvider>(
//       builder: (context, settings, child) {
//         if (!settings.canClaimDailyReward) return const SizedBox.shrink();

//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [Colors.amber.shade400, Colors.orange.shade600]),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
//           ),
//           child: Row(
//             children: [
//               const Text('🪙', style: TextStyle(fontSize: 32)),
//               const SizedBox(width: 16),
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Daily Reward!', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text('Claim your 20 free coins for today', style: TextStyle(color: Colors.white, fontSize: 13)),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () => settings.claimDailyReward(),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.orange,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text('Claim'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class ClassicModeView extends StatelessWidget {
  const ClassicModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProgressProvider>(
      builder: (context, progress, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const DailyCoinClaimCard(),
              const SizedBox(height: 8),
              _buildDifficultySection(context, 'Easy', 'Perfect for beginners', Icons.emoji_emotions_outlined, Colors.green, SubjectsData.easySubjects, progress),
              _buildDifficultySection(context, 'Medium', 'Getting challenging', Icons.emoji_objects_outlined, Colors.orange, SubjectsData.mediumSubjects, progress),
              _buildDifficultySection(context, 'Hard', 'For word masters', Icons.psychology_outlined, Colors.red, SubjectsData.hardSubjects, progress),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }


  Widget _buildDifficultySection(BuildContext context, String title, String subtitle, IconData icon, Color color, List<Subject> subjects, GameProgressProvider progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDifficultyHeader(title, subtitle, icon, color),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.95, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return SubjectCard(
              subject: subject,
              completedCount: progress.getCompletedWords(subject.id).length,
              isCompleted: progress.isSubjectCompleted(subject.id, subject.words.length),
              difficultyColor: color,
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDifficultyHeader(String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final int completedCount;
  final bool isCompleted;
  final Color difficultyColor;

  const SubjectCard({
    super.key,
    required this.subject,
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
                : [subject.color.withOpacity(0.8), subject.color],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: (isCompleted ? Colors.grey : difficultyColor).withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 45, height: 45,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text(subject.icon, style: const TextStyle(fontSize: 24))),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subject.name, 
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), 
                    textAlign: TextAlign.center, 
                    maxLines: 2, 
                    overflow: TextOverflow.ellipsis
                  ),
                ],
              ),
            ),
            if (isCompleted)
              const Positioned(top: 8, right: 8, child: Icon(Icons.check_circle, color: Colors.white, size: 16)),
          ],
        ),
      ),
    );
  }
}