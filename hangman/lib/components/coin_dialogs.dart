import 'package:flutter/material.dart';
import '../services/game_setting.dart';

class CoinDialogs {
  static void showNotEnoughCoinsDialog({
    required BuildContext context,
    required GameSettingsProvider settingsProvider,
    VoidCallback? onAdSuccess,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.shade400,
                  Colors.purple.shade700,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.shade800.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Stack(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Positioned.fill(
                        child: Center(
                          child: Text('🪙', style: TextStyle(fontSize: 40)),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Title
                const Text(
                  'Not Enough Coins!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Message
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    'Watch a short ad to earn 20 coins and continue playing!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Watch Ad Button
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              
                              // Show loading indicator
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                              
                              // Try to get hints via ad
                              final success = await settingsProvider.getCoinsViaRewardedAd(context);
                              
                              // Dismiss loading dialog
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                              
                              if (success && onAdSuccess != null) {
                                onAdSuccess();
                              }
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_circle_filled, 
                                    color: Colors.purple.shade700, 
                                    size: 20,
                                  ),
                                  const SizedBox(width: 2),
                                  
                                  Text(
                                    'Ad (+20 🪙)',
                                    style: TextStyle(
                                      color: Colors.purple.shade700,
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
                    
                    // Cancel Button
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Material(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: const Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),                
              ],
            ),
          ),
        );
      },
    );
  }
}
