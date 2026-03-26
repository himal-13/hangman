import 'package:audioplayers/audioplayers.dart';

/// Singleton that manages all game audio using audioplayers.
/// Maps game events to the available audio files in assets/audio/.
class AudioManager {
  AudioManager._();
  static final AudioManager instance = AudioManager._();

  final AudioPlayer _player = AudioPlayer();
  bool _muted = false;
  bool get isMuted => _muted;

  // ── Audio file names (relative to assets/audio/) ──────────────────────────
  static const String _correct = 'picked.mp3';       // correct letter guess
  static const String _wrong   = 'failed.mp3';       // wrong letter guess
  static const String _win     = 'level-complete.mp3'; // player wins
  static const String _lose    = 'failed.mp3';       // player loses
  static const String _click   = 'picked.mp3';       // button press

  /// Preload logic (decorative for audioplayers in this simple use case).
  Future<void> preload() async {
    // Prefix is 'audio/' because AssetSource expects path relative to 'assets/'.
    // We can pre-set the source if we want to minimize latency, but for
    // sound effects, we'll just play them as needed.
  }

  void toggleMute() => setMuted(!_muted);

  /// Sets whether audio should be muted.
  void setMuted(bool muted) {
    _muted = muted;
    if (muted) {
      _player.stop();
    }
  }

  void _play(String file) async {
    if (_muted) return;
    
    // For short sound effects, we can reuse the player or create new ones.
    // Overlapping sounds are better handled by separate players.
    // To keep it simple and efficient, we'll use a one-off player for 
    // each sound to allow overlapping (like the original FlameAudio).
    
    final player = AudioPlayer();
    await player.play(AssetSource('audio/$file'));
    
    // Dispose after play to avoid memory leaks
    player.onPlayerComplete.first.then((_) => player.dispose());
  }

  void playCorrect() => _play(_correct);
  void playWrong()   => _play(_wrong);
  void playWin()     => _play(_win);
  void playLose()    => _play(_lose);
  void playClick()   => _play(_click);
}
