import 'package:flame_audio/flame_audio.dart';

void main() async {
  await FlameAudio.createPool('picked.wav', minPlayers: 3, maxPlayers: 4);
}
