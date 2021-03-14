import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';
import 'package:rive/rive.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/race_game.dart';
import 'package:toilet_racer/services/timer_service.dart';

class StartMenu extends StatefulWidget {
  final RaceGame game;

  const StartMenu(this.game);

  @override
  _StartMenuState createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu> {
  final riveFileName = 'assets/animations/toilet_lid-up.riv';
  Rive rive;

  Artboard _artboard;
  SimpleAnimation _toiletController;
  SimpleAnimation get toiletController => _toiletController;

  final TimerService _timerService = locator<TimerService>();

  @override
  void initState() {
    _loadRiveFile();

    super.initState();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      _toiletController = SimpleAnimation('lid-up')
        ..isActiveChanged.addListener(() {
          if (toiletController.isActive) {
            print('Animation started playing');
          } else {
            print('Animation stopped playing');
            widget.game.startGame();
          }
        });

      setState(() {
        _artboard = file.mainArtboard;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const foregroundColor = Colors.orangeAccent;
    const outlineColor = Colors.brown;
    const shadowWidth = 2.5;

    const buttonStyle = TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.bold,
      color: foregroundColor,
      shadows: [
        Shadow(
            // bottomLeft
            offset: Offset(-shadowWidth, -shadowWidth),
            color: outlineColor),
        Shadow(
            // bottomRight
            offset: Offset(shadowWidth, -shadowWidth),
            color: outlineColor),
        Shadow(
            // topRight
            offset: Offset(shadowWidth, shadowWidth),
            color: outlineColor),
        Shadow(
            // topLeft
            offset: Offset(-shadowWidth, shadowWidth),
            color: outlineColor),
      ],
    );

    const titleStyle =
        TextStyle(fontSize: 128, color: Colors.brown, fontFamily: 'NerkoOne');

    const spacing = 72.0;
    const buttonSpacing = 36.0;

    return Stack(
      children: [
        if (_artboard != null)
          Rive(
            artboard: _artboard,
            fit: BoxFit.cover,
          ),
        Padding(
          padding: const EdgeInsets.all(startMenuMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: [
                    Text(
                        _timerService.seconds.value == null
                            ? ''
                            : 'SCORE: ${_timerService.seconds.value}',
                        style: titleStyle),
                    SizedBox(height: spacing),
                    Text(
                      title,
                      style: titleStyle,
                    ),
                    SizedBox(height: spacing),
                    TextButton(
                      onPressed: () {
                        startGameAnimation();
                      },
                      child: Text('PLAY',
                          style: buttonStyle.copyWith(
                              fontSize: buttonStyle.fontSize + 32)),
                    ),
                    SizedBox(height: spacing),
                    TextButton(
                      onPressed: () {},
                      child: Text('LEVELS', style: buttonStyle),
                    ),
                    SizedBox(height: buttonSpacing),
                    TextButton(
                      onPressed: () {
                        GamesServices.showLeaderboards();
                      },
                      child: Text('SCORE', style: buttonStyle),
                    ),
                    SizedBox(height: buttonSpacing),
                    TextButton(
                      onPressed: () {
                        GamesServices.showAchievements();
                      },
                      child: Text('AWARDS', style: buttonStyle),
                    ),
                    SizedBox(height: buttonSpacing),
                    SizedBox(height: spacing),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  void startGameAnimation() {
    _artboard.addController(_toiletController);
  }
}
