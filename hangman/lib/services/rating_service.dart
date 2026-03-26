import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RatingService {
  static final RatingService _instance = RatingService._internal();
  static RatingService get instance => _instance;

  final RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 0,
    remindDays: 1,
    remindLaunches: 5,
    googlePlayIdentifier: 'com.imal1.hangman.app', 
    appStoreIdentifier: '', // Replace with your actual app ID
  );

  RatingService._internal();

  Future<void> init() async {
    await _rateMyApp.init();
  }

  void showRatingDialog(BuildContext context) {
    _rateMyApp.showRateDialog(
      context,
      title: 'Rate this app',
      message: 'If you like this app, please take a little bit of your time to review it!',
      rateButton: 'RATE',
      noButton: 'NO THANKS',
      laterButton: 'MAYBE LATER',
      listener: (RateMyAppDialogButton button) {
        switch (button) {
          case RateMyAppDialogButton.rate:
            debugPrint('Clicked on Rate');
            break;
          case RateMyAppDialogButton.later:
            debugPrint('Clicked on Later');
            break;
          case RateMyAppDialogButton.no:
            debugPrint('Clicked on No');
            break;
        }
        return true;
      },
      dialogStyle: const DialogStyle(),
      onDismissed: () => _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  }

  void showStarRatingDialog(BuildContext context) {
      _rateMyApp.showStarRateDialog(
        context,
        title: 'Rate this app',
        message: 'You like this app ? Then take a little bit of your time to leave a rating :',
        actionsBuilder: (context, stars) {
          return [
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                debugPrint('Thanks for the $stars star(s) !');
                await _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ];
        },
        ignoreNativeDialog: true,
        dialogStyle: const DialogStyle(
          titleAlign: TextAlign.center,
          messageAlign: TextAlign.center,
          messagePadding: EdgeInsets.only(bottom: 20),
        ),
        starRatingOptions: const StarRatingOptions(),
        onDismissed: () => _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
      );
  }

  Future<bool> shouldShowRating() async {
    final prefs = await SharedPreferences.getInstance();
    final lastShown = prefs.getString('last_rating_prompt_date');
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (lastShown == today) {
      return false;
    }
    
    // The doNotOpenAgain check might not be direct in this version
    // We'll rely on shouldOpenDialog which takes all conditions into account
    // including if the user has already rated or said no.
    return _rateMyApp.shouldOpenDialog;
  }

  Future<void> markRatingPromptShown() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    await prefs.setString('last_rating_prompt_date', today);
  }
}
