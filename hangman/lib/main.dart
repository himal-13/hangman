import 'package:flutter/material.dart';
import 'package:hangman/screens/home_page.dart';
import 'package:hangman/services/game_progress.dart';
import 'package:hangman/services/game_setting.dart';
import 'package:hangman/audio/audio_manager.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hangman/services/admob_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize AdMob
  await MobileAds.instance.initialize();
  
  // Preload audio files
  await AudioManager.instance.preload();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (_) => GameProgressProvider()),
        ChangeNotifierProvider(create: (_) => GameSettingsProvider()),
        Provider(create: (_) => AdService()..loadRewardedAd()),
      ],
      child: MaterialApp(
        title: 'Subject Hangman',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}