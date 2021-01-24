import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/services/audio_service.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  locator
      .registerSingleton<AudioService>(AudioService.getInstance());
}