// lib/audio/audio_manager.dart

import 'package:flame_audio/flame_audio.dart';

/// Singleton that manages all game audio using FlameAudio.
/// Maps game events to the available audio files in assets/audio/.
class AudioManager {
  AudioManager._();
  static final AudioManager instance = AudioManager._();

  bool _muted = false;
  bool get isMuted => _muted;

  // ── Audio file names (must match files in assets/audio/) ──────────────────
  static const String _correct = 'picked.mp3';       // correct letter guess
  static const String _wrong   = 'failed.mp3';       // wrong letter guess
  static const String _win     = 'level-complete.mp3'; // player wins
  static const String _lose    = 'failed.mp3';       // player loses
  static const String _click   = 'picked.mp3';       // button press

  /// Preload all audio files so first-play latency is minimal.
  Future<void> preload() async {
    await FlameAudio.audioCache.loadAll([
      _correct,
      _wrong,
      _win,
      _lose,
    ]);
  }

  void toggleMute() => _muted = !_muted;

  void _play(String file) {
    if (_muted) return;
    FlameAudio.play(file);
  }

  void playCorrect() => _play(_correct);
  void playWrong()   => _play(_wrong);
  void playWin()     => _play(_win);
  void playLose()    => _play(_lose);
  void playClick()   => _play(_click);
}
