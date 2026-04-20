import 'package:flutter/material.dart';
import '../models/player.dart';
import 'main_menu_screen.dart';

class Versus1v1ResultScreen extends StatelessWidget {
  final List<MultiplayerPlayer> players;
  final Map<int, int> playerWordsFound;

  const Versus1v1ResultScreen({
    super.key,
    required this.players,
    required this.playerWordsFound,
  });

  List<MultiplayerPlayer> getWinners() {
    if (players.isEmpty) return [];
    
    // Sort primarily by score, secondarily by words found
    List<MultiplayerPlayer> sortedPlayers = List.from(players);
    sortedPlayers.sort((a, b) {
      if (b.score != a.score) {
        return b.score.compareTo(a.score);
      }
      return (playerWordsFound[b.id] ?? 0).compareTo(playerWordsFound[a.id] ?? 0);
    });

    // Check if there's a tie for first place
    int highestScore = sortedPlayers.first.score;
    int highestWords = playerWordsFound[sortedPlayers.first.id] ?? 0;
    
    return sortedPlayers.where((p) => 
      p.score == highestScore && (playerWordsFound[p.id] ?? 0) == highestWords
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final winners = getWinners();
    final bool isTie = winners.length > 1;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Final Results', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Winner announcement
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        !isTie ? Icons.emoji_events : Icons.handshake,
                        color: !isTie ? Colors.amber : Colors.blue,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        !isTie ? '${winners.first.name} Wins!' : 'It\'s a Tie!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: !isTie ? winners.first.color : Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (isTie) ...[
                        const SizedBox(height: 8),
                        const Text(
                          'Players performed equally!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Player results
                ...players.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildPlayerResultCard(p, winners.contains(p)),
                )),

                const SizedBox(height: 48),

                // Action buttons
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenuScreen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('MAIN MENU'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade800,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerResultCard(MultiplayerPlayer player, bool isWinner) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isWinner ? Colors.amber.shade300 : player.color.withOpacity(0.3),
          width: isWinner ? 3 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: player.color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: player.color.withOpacity(0.2),
                  child: Icon(
                    isWinner ? Icons.emoji_events : Icons.person,
                    color: player.color,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: player.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Score: ${player.score}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.book, color: Colors.blue, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Words Found: ${playerWordsFound[player.id] ?? 0}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(137, 158, 158, 158),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isWinner)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.yellow.shade700, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'WINNER',
                      style: TextStyle(
                        color: Color.fromARGB(174, 255, 235, 59),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}