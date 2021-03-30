import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/race_game.dart';
import 'package:toilet_racer/services/game_service.dart';

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

  final GameService _gameService = locator<GameService>();

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
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              widget.game.onPlayButtonPressed();
            });
          }
        });

      setState(() {
        _artboard = file.mainArtboard;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.headline1.copyWith(color: Colors.brown);
    final buttonStyle = Theme.of(context).textTheme.headline2;

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
                    SizedBox(height: spacing),
                    Text(title, style: titleStyle),
                    SizedBox(height: spacing),
                    TextButton(
                      onPressed: startGameAnimation,
                      child: Text('PLAY',
                          style: buttonStyle.copyWith(
                              fontSize: titleStyle.fontSize)),
                    ),
                    SizedBox(height: spacing),
                    TextButton(
                      onPressed: () {},
                      child: Text('LEVELS', style: buttonStyle),
                    ),
                    SizedBox(height: buttonSpacing),
                    TextButton(
                      onPressed: () =>
                          _gameService.showLeaderboards(kAndroidLeaderBoard),
                      child: Text('SCORE', style: buttonStyle),
                    ),
                    SizedBox(height: buttonSpacing),
                    TextButton(
                      onPressed: _gameService.showAchievements,
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
