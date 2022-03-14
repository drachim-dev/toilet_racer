import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/audio_service.dart';
import 'package:toilet_racer/services/timer_service.dart';

class OverlayUi extends StatefulWidget {
  const OverlayUi({Key? key}) : super(key: key);

  @override
  _OverlayUiState createState() => _OverlayUiState();
}

class _OverlayUiState extends State<OverlayUi> {
  final AudioService _audioService = locator<AudioService>();
  final TimerService _timerService = locator<TimerService>();

  bool _musicEnabled = false;

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
            icon: _musicEnabled
                ? const Icon(Icons.volume_up, color: Colors.white)
                : const Icon(Icons.volume_off, color: Colors.white),
            iconSize: kOverlayIconSize,
            onPressed: () => _toggleMusic(),
          ),
          ValueListenableBuilder(
            valueListenable: _timerService.seconds,
            builder: (_, double? value, Widget? child) => Expanded(
                child: Text(
              value.toString(),
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            )),
          ),
          const SizedBox(width: kOverlayIconSize),
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
