import 'package:flame_audio/flame_audio.dart';
import 'package:toilet_racer/app/constants.dart';

class AudioService {
  static AudioService _instance;

  static AudioService getInstance() {
    if (_instance == null) {
      FlameAudio.bgm.initialize();
      FlameAudio.audioCache.prefix = audioPath;
      _instance = AudioService().._init();
    }
    return _instance;
  }

  void _init() {
    // preload bg audio
    FlameAudio.bgm.audioCache.loadAll([
      audioBackgroundPath,
    ]);

    // preload audio
    FlameAudio.audioCache.loadAll([
      audioToiletDropSound,
    ]);
  }

  void playBgMusic() =>
      FlameAudio.bgm.play(audioBackgroundPath, volume: audioBackgroundVolume);

  /// plays 'player drops off the road' sound effect
  void playDropSound(String path) {
    FlameAudio.play(path, volume: audioDropVolume);
  }

  void pause() => FlameAudio.bgm.pause();
}
