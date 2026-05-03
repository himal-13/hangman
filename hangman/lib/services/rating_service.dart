import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingService {
  static const String _isRatedKey = 'is_rated';
  static const String _lastShownDateKey = 'last_rating_shown_date';
  
  static DateTime _sessionStartTime = DateTime.now();
  static int _sessionLevelsPlayed = 0;

  /// Resets session-specific tracking data.
  static void resetSession() {
    _sessionStartTime = DateTime.now();
    _sessionLevelsPlayed = 0;
  }

  /// Increments the count of levels played in the current session.
  static void levelCompleted() {
    _sessionLevelsPlayed++;
  }

  /// Checks conditions and shows the rating dialog if appropriate.
  static Future<void> checkAndShow(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Check if user already rated (never show again)
    if (prefs.getBool(_isRatedKey) ?? false) {
      return;
    }
    
    // 2. Check if shown today (once per day limit)
    final lastShownStr = prefs.getString(_lastShownDateKey);
    final now = DateTime.now();
    final todayStr = "${now.year}-${now.month}-${now.day}";
    
    if (lastShownStr == todayStr) {
      return;
    }
    
    // 3. Check conditions: 45 seconds play time OR at least one level played
    final playDuration = now.difference(_sessionStartTime).inSeconds;
    if (playDuration < 45 && _sessionLevelsPlayed < 1) {
      return;
    }
    
    // Show the dialog
    if (context.mounted) {
      _showRatingDialog(context, prefs, todayStr);
    }
  }

  static void _showRatingDialog(BuildContext context, SharedPreferences prefs, String todayStr) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A237E), // Deep Indigo
                const Color(0xFF311B92), // Deep Purple
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.stars_rounded,
                color: Colors.amber,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                'Enjoying the Game?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your rating helps us improve and bring more levels to you!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        // Save that it was shown today and close
                        prefs.setString(_lastShownDateKey, todayStr);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.white.withOpacity(0.3)),
                        ),
                      ),
                      child: Text(
                        'Later',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Mark as rated, save date, navigate to store, and close
                        await prefs.setBool(_isRatedKey, true);
                        await prefs.setString(_lastShownDateKey, todayStr);
                        _navigateToPlayStore();
                        if (context.mounted) Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: const Color(0xFF1A237E),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        'Rate Now',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _navigateToPlayStore() async {
    const packageName = 'com.imal1.hangman.app';
    final url = Uri.parse('https://play.google.com/store/apps/details?id=$packageName');
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
