import 'package:flame_audio/flame_audio.dart';

///
/// Call `AudioManager.load()` to pre-cache the sounds before playing.
/// Then, you can call the static methods from anywhere in your app:
/// `AudioManager.playSuccess();`
/// `AudioManager.playFailed();`
class AudioManager {
  static bool _soundOn = true; // Add a static boolean to track the sound state

  /// Pre-caches all audio files used by the manager for instant playback.
  static Future<void> load() async {
    await FlameAudio.audioCache.loadAll([
      'picked.wav',
      'failed.wav',
      'level-complete.wav',
    ]);
  }

  /// Plays the 'level-complete' sound effect from your assets.
  static void playLevelComplete() {
    if (_soundOn) { // Check if sound is on before playing
      FlameAudio.play('level-complete.wav');
    }
  }

  static void playCorrect() {
    if (_soundOn) { // Check if sound is on before playing
      FlameAudio.play('picked.wav');
    }
  }

  static void playWrong() {
    if (_soundOn) { // Check if sound is on before playing
      FlameAudio.play('failed.wav');
    }
  }

  /// Toggles the sound on/off state.
  static void toggleSound() {
    _soundOn = !_soundOn;
  }

  /// Returns the current state of the sound.
  static bool get isSoundOn => _soundOn;

  /// Releases the audio player's resources.
  static void dispose() {
    // FlameAudio handles internal players efficiently, 
    // but we can stop all if needed on global dispose.
    FlameAudio.bgm.stop();
  }
}