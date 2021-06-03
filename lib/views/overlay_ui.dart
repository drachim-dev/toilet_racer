import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/services/timer_service.dart';

class OverlayUi extends StatefulWidget {
  @override
  _OverlayUiState createState() => _OverlayUiState();
}

class _OverlayUiState extends State<OverlayUi> {
  final MobileAudioService _audioService = locator<MobileAudioService>();
  final TimerService _timerService = locator<TimerService>();

  bool _musicEnabled;

  @override
  void initState() {
    super.initState();

    _musicEnabled = _audioService.isAudioEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon:
                _musicEnabled ? Icon(Icons.volume_up) : Icon(Icons.volume_off),
            iconSize: kOverlayIconSize,
            onPressed: () => _toggleMusic(),
          ),
          ValueListenableBuilder(
            valueListenable: _timerService.seconds,
            builder: (_, int value, Widget child) => Expanded(
                child: Text(
              '$value',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            )),
          ),
          SizedBox(width: kOverlayIconSize),
        ],
      ),
    );
  }

  void _toggleMusic() {
    setState(() => _musicEnabled = !_musicEnabled);
    _audioService.setAudioEnabled(_musicEnabled);
    _audioService.playBackgroundMusic(menu: false);
  }
}
