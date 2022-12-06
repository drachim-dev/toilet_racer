import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';

abstract class AudioService {
  Future<AudioService> init();

  Future<void> playBackgroundMusic({required bool menu});

  Future<void> playDropSound(String path);

  void setAudioEnabled(bool enabled);

  void stopBackgroundMusic();

  bool isAudioEnabled();
}

class MobileAudioService implements AudioService {
  final SharedPreferences _prefService = locator<SharedPreferences>();
  // Use custom Bgm instance with fixedPlayer instead of FlameAudio.bgm to prevent MediaPlayerNative error.
  final Bgm _bgm = Bgm(audioCache: AudioCache(prefix: kAudioPath));

  @override
  Future<MobileAudioService> init() async {
    _bgm.initialize();

    FlameAudio.audioCache.prefix = kAudioPath;

    // preload bg audio
    await _bgm.audioPlayer.audioCache
        .loadAll([kAudioBackgroundPath, kAudioMenuBackgroundPath]);

    // preload audio
    await FlameAudio.audioCache.loadAll([
      kAudioToiletDropSound,
    ]);
    return this;
  }

  @override
  Future<void> playBackgroundMusic({bool menu = true}) async {
    if (isAudioEnabled()) {
      await _bgm.play(menu ? kAudioMenuBackgroundPath : kAudioBackgroundPath,
          volume: kAudioBackgroundVolume);
    }
  }

  /// plays 'player drops off the road' sound effect
  @override
  Future<void> playDropSound(String path) async {
    if (isAudioEnabled()) {
      await FlameAudio.play(path, volume: kAudioDropVolume);
    }
  }

  @override
  void setAudioEnabled(bool enabled) {
    _prefService.setBool(kPrefKeyAudioEnabled, enabled);
    stopBackgroundMusic();
  }

  @override
  void stopBackgroundMusic() {
    _bgm.stop();
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
  Future<void> playBackgroundMusic({required bool menu}) async {}

  @override
  Future<void> playDropSound(String path) async {}

  @override
  void setAudioEnabled(bool enabled) {}

  @override
  bool isAudioEnabled() {
    return true;
  }

  @override
  void stopBackgroundMusic() {}
}
