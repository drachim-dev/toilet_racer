import 'package:flutter/material.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/services/game_service.dart';
import 'package:toilet_racer/views/flip_widget.dart';

class StartMenu extends StatefulWidget {
  final VoidCallback onPlayPressed, onCreditsPressed;

  const StartMenu(this.onPlayPressed, this.onCreditsPressed);

  @override
  _StartMenuState createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu>
    with SingleTickerProviderStateMixin {
  final GameService _gameService = locator<GameService>();
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      value: 0,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.headline1.copyWith(color: Colors.brown);
    final buttonStyle = Theme.of(context).textTheme.headline2;

    const spacing = 72.0;
    const buttonSpacing = 36.0;

    final bottomImage = Image.asset(
      'assets/animations/toilet_no-lid.webp',
    );
    final topImage = Image.asset('assets/animations/toilet_lid.webp');

    return Stack(
      children: [
        FlipWidget(
          background: bottomImage,
          flippable: topImage,
          controller: _controller,
        ),
        Padding(
          padding: const EdgeInsets.all(kStartMenuMargin),
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
                    Text(kTitle, style: titleStyle),
                    SizedBox(height: spacing),
                    TextButton(
                      onPressed: _startGame,
                      child: Text('PLAY',
                          style: buttonStyle.copyWith(
                              fontSize: titleStyle.fontSize)),
                    ),
                    SizedBox(height: spacing),
                    TextButton(
                      onPressed: widget.onCreditsPressed,
                      child: Text('CREDITS', style: buttonStyle),
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

  Future<void> _startGame() async {
    await _controller.forward();
    widget.onPlayPressed();
  }
}
