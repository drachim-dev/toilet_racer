import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/audio_service.dart';

class OverlayUi extends StatefulWidget {
  final bool soundEnabled;

  OverlayUi({this.soundEnabled});

  @override
  _OverlayUiState createState() => _OverlayUiState(musicEnabled: soundEnabled);
}

class _OverlayUiState extends State<OverlayUi> {
  final SharedPreferences _prefService = locator<SharedPreferences>();
  final AudioService _audioService = locator<AudioService>();

  bool musicEnabled;

  _OverlayUiState({@required this.musicEnabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IconButton(
          icon: musicEnabled
              ? Icon(Icons.volume_up, size: overlayUiIconSize)
              : Icon(Icons.volume_off, size: overlayUiIconSize),
          color: Colors.white,
          onPressed: () => _toggleMusic()),
    );
  }

  void _toggleMusic() {
    setState(() => musicEnabled = !musicEnabled);

    _prefService.setBool(prefKeyMusicEnabled, musicEnabled);
    musicEnabled ? _audioService.playMusic() : _audioService.pause();
  }
}
