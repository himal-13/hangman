import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static bool _isMuted = false;
  static const _audioPrefix = 'assets/audio/';

  static AudioPool? _pickedPool;
  static AudioPool? _failedPool;
  static AudioPool? _levelCompletePool;

  /// Preloads all sound effects into the audio cache to eliminate lag and
  /// late playing during gameplay.
  static Future<void> load() async {
    try {
      FlameAudio.audioCache.prefix = _audioPrefix;
      await FlameAudio.audioCache.loadAll([
        'picked.wav',
        'failed.wav',
        'level-complete.wav',
      ]);

      _pickedPool = await FlameAudio.createPool('picked.wav', minPlayers: 2, maxPlayers: 4);
      _failedPool = await FlameAudio.createPool('failed.wav', minPlayers: 2, maxPlayers: 4);
      _levelCompletePool = await FlameAudio.createPool('level-complete.wav', minPlayers: 1, maxPlayers: 2);

      final prefs = await SharedPreferences.getInstance();
      _isMuted = prefs.getBool('sound_muted') ?? false;
    } catch (e, stackTrace) {
      print('Error loading audio assets: $e');
      print(stackTrace);
    }
  }

  /// Updates the mute status from shared preferences.
  /// This should be called whenever the sound setting is toggled in the UI.
  static Future<void> toggleSound() async {
    final prefs = await SharedPreferences.getInstance();
    _isMuted = prefs.getBool('sound_muted') ?? false;
  }

  static Future<void> _playSound(String filename, AudioPool? pool) async {
    if (_isMuted) {
      return;
    }

    try {
      if (pool != null) {
        pool.start();
      } else {
        FlameAudio.play(filename);
      }
    } catch (e, stackTrace) {
      print('Error playing audio "$filename": $e');
      print(stackTrace);
    }
  }

  /// Plays the "correct" sound effect (picked.wav).
  static void playCorrect() {
    _playSound('picked.wav', _pickedPool);
  }

  /// Plays the "wrong" sound effect (failed.wav).
  static void playWrong() {
    _playSound('failed.wav', _failedPool);
  }

  /// Plays the "level complete" sound effect (level-complete.wav).
  static void playLevelComplete() {
    _playSound('level-complete.wav', _levelCompletePool);
  }
}
