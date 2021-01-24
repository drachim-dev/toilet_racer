import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/audio_service.dart';

class OverlayUi extends StatefulWidget {
  @override
  _OverlayUiState createState() => _OverlayUiState();
}

class _OverlayUiState extends State<OverlayUi> {
  final SharedPreferences _prefService = locator<SharedPreferences>();
  final AudioService _audioService = locator<AudioService>();

  bool _musicEnabled;

  @override
  void initState() {
    super.initState();

    _musicEnabled = _prefService.getBool(prefKeyMusicEnabled) ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IconButton(
          icon: _musicEnabled
              ? Icon(Icons.volume_up, size: overlayUiIconSize)
              : Icon(Icons.volume_off, size: overlayUiIconSize),
          color: Colors.white,
          onPressed: () => _toggleMusic()),
    );
  }

  void _toggleMusic() {
    setState(() => _musicEnabled = !_musicEnabled);

    _prefService.setBool(prefKeyMusicEnabled, _musicEnabled);
    _musicEnabled ? _audioService.playBgMusic() : _audioService.pause();
  }
}
