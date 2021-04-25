import 'package:flame_audio/flame_audio.dart';
import 'package:toilet_racer/app/constants.dart';

class AudioService {
  Future<AudioService> init() async {
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.prefix = kAudioPath;

    // preload bg audio
    await FlameAudio.bgm.audioCache.loadAll([
      kAudioBackgroundPath,
    ]);

    // preload audio
    await FlameAudio.audioCache.loadAll([
      kAudioToiletDropSound,
    ]);
    return this;
  }

  void playBgMusic() =>
      FlameAudio.bgm.play(kAudioBackgroundPath, volume: kAudioBackgroundVolume);

  /// plays 'player drops off the road' sound effect
  void playDropSound(String path) {
    FlameAudio.play(path, volume: kAudioDropVolume);
  }

  void pause() => FlameAudio.bgm.pause();
}

/// This service provides an empty implementation of the AudioService for flutter web target
/// because FlameAudio does not support web right now.
class WebAudioService implements AudioService {
  @override
  Future<AudioService> init() async {
    return this;
  }

  @override
  void pause() {}

  @override
  void playBgMusic() {}

  @override
  void playDropSound(String path) {}
}
