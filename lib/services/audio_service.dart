import 'package:flame/flame.dart';
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
    await Flame.audio.loadAll([
      audioBackgroundPath,
    ]);
  }

  void playMusic() {
    Flame.bgm.play(audioBackgroundPath, volume: audioBackgroundVolume);
  }

  /// plays 'driver drops off the road' sound effect
  void playDropSound(String path) {
    Flame.audio.play(path, volume: audioDropVolume);
  }

  void pause() => Flame.bgm.pause();
}
