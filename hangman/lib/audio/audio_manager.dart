import 'package:audioplayers/audioplayers.dart';

///
/// Call `FlutterAudioManager.load()` to pre-cache the sounds before playing.
/// Then, you can call the static methods from anywhere in your app:
/// `FlutterAudioManager.playSuccess();`
/// `FlutterAudioManager.playFailed();`
class AudioManager {
  static final AudioPlayer _player = AudioPlayer();
  static bool _soundOn = true; // Add a static boolean to track the sound state

  /// Pre-caches all audio files used by the manager for instant playback.
  static Future<void> load() async {
    // await AudioPlayer().setSource(AssetSource('audio/success.mp3'));
    // await AudioPlayer().setSource(AssetSource('audio/failed.mp3'));

    await AudioPlayer().setSource(AssetSource('audio/picked.mp3'));
    await AudioPlayer().setSource(AssetSource('audio/failed.mp3'));
    await AudioPlayer().setSource(AssetSource('audio/level-complete.mp3'));
  }

 
  /// Plays the 'level-complete' sound effect from your assets.
  static void playLevelComplete() {
    if (_soundOn) { // Check if sound is on before playing
      _player.play(AssetSource('audio/level-complete.mp3'));
    }
  }



  static void playCorrect() {
    if (_soundOn) { // Check if sound is on before playing
      _player.play(AssetSource('audio/picked.mp3'));
    }
  }
  static void playWrong() {
    if (_soundOn) { // Check if sound is on before playing
      _player.play(AssetSource('audio/failed.mp3'));
    }
  }

  /// Toggles the sound on/off state.
  static void toggleSound() {
    _soundOn = !_soundOn;
  }

  /// Returns the current state of the sound.
  static bool get isSoundOn => _soundOn;

  /// Releases the audio player's resources.
  ///
  /// Call this when the app is being closed to free up resources.
  static void dispose() {
    _player.dispose();
  }
}