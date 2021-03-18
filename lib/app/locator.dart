import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/services/ad_service.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/services/game_service.dart';
import 'package:toilet_racer/services/timer_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  locator.registerSingletonAsync<AudioService>(
      () => kIsWeb ? WebAudioService().init() : AudioService().init());
  locator.registerSingletonAsync<AdService>(
      () => kIsWeb ? WebAdService().init() : AdService().init());
  locator.registerSingleton<GameService>(GameService());
  locator.registerSingleton<TimerService>(TimerService());
}
