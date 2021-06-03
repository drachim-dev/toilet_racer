import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';

abstract class AudioService {
  Future<AudioService> init();

  void playBackgroundMusic({bool menu});

  void playDropSound(String path);

  void setAudioEnabled(bool enabled);

  bool isAudioEnabled();
}

class MobileAudioService implements AudioService {
  final SharedPreferences _prefService = locator<SharedPreferences>();

  @override
  Future<MobileAudioService> init() async {
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.prefix = kAudioPath;

    // preload bg audio
    await FlameAudio.bgm.audioCache
        .loadAll([kAudioBackgroundPath, kAudioMenuBackgroundPath]);

    // preload audio
    await FlameAudio.audioCache.loadAll([
      kAudioToiletDropSound,
    ]);
    return this;
  }

  @override
  void playBackgroundMusic({bool menu = true}) {
    if (isAudioEnabled()) {
      FlameAudio.bgm.play(
          menu ? kAudioMenuBackgroundPath : kAudioBackgroundPath,
          volume: kAudioBackgroundVolume);
    }
  }

  /// plays 'player drops off the road' sound effect
  @override
  void playDropSound(String path) {
    if (isAudioEnabled()) {
      FlameAudio.play(path, volume: kAudioDropVolume);
    }
  }

  @override
  void setAudioEnabled(bool enabled) {
    _prefService.setBool(kPrefKeyAudioEnabled, enabled);
    FlameAudio.bgm.stop();
  }

  @override
  bool isAudioEnabled() {
    return _prefService.getBool(kPrefKeyAudioEnabled) ?? true;
  }
}

/// This service provides an empty implementation of the AudioService for flutter web target
/// because FlameAudio does not support web right now.
class WebAudioService implements AudioService {
  @override
  Future<AudioService> init() async {
    return this;
  }

  @override
  void playBackgroundMusic({bool menu}) {}

  @override
  void playDropSound(String path) {}

  @override
  void setAudioEnabled(bool enabled) {}

  @override
  bool isAudioEnabled() {
    return true;
  }
}
