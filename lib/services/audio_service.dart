import 'package:flame_audio/flame_audio.dart';
import 'package:toilet_racer/app/constants.dart';

class AudioService {
  static AudioService _instance;

  static Future<AudioService> getInstance() async {
    if (_instance == null) {
      _instance = AudioService();
      await _instance.init();
    }
    return _instance;
  }

  Future<void> init() async {
    // preload audio
    await FlameAudio.audioCache.loadAll([
      audioBackgroundPath,
    ]);
  }

  void playMusic() {
    FlameAudio.bgm.play(audioBackgroundPath, volume: audioBackgroundVolume);
  }

  /// plays 'driver drops off the road' sound effect
  void playDropSound(String path) {
    FlameAudio.play(path, volume: audioDropVolume);
  }

  void pause() => FlameAudio.bgm.pause();
}
