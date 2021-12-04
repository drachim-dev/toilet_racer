import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/app/theme.dart';
import 'package:toilet_racer/race_game_mode.dart';
import 'package:toilet_racer/views/flip_widget.dart';
import 'package:toilet_racer/widgets/shadow_icon.dart';

class StartMenu extends StatefulWidget {
  final VoidCallback onCreditsPressed, onLeaderboardPressed;

  final void Function({@required GameModeIdentifier gameModeIdentifier})
      onStartGamePressed;

  const StartMenu(this.onStartGamePressed, this.onCreditsPressed,
      this.onLeaderboardPressed);

  @override
  _StartMenuState createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final SharedPreferences _prefService = locator<SharedPreferences>();

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
    final theme = Theme.of(context);

    final titleStyle = theme.textTheme.headline1.copyWith(color: Colors.brown);
    final buttonStyle = theme.textTheme.headline2;

    final iconColor = secondaryColor;
    final shadowColor = primaryColor;
    final iconSize = buttonStyle.fontSize - 8;
    final iconPadding = EdgeInsets.only(right: 16);

    const spacing = 86.0;

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
          padding: const EdgeInsets.all(kMenuScreenMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(kTitle, style: titleStyle),
                    SizedBox(height: spacing * 3),
                    ElevatedButton.icon(
                      icon: ShadowIcon(
                        Icons.play_circle_outline_outlined,
                        size: iconSize,
                        color: iconColor,
                        shadowColor: shadowColor,
                        padding: iconPadding,
                      ),
                      onPressed: () => _startGame(GameModeIdentifier.career),
                      label: Text(hasCareerProgress ? 'Continue' : 'PLAY',
                          style: buttonStyle),
                    ),
                    SizedBox(height: spacing),
                    if (hasCareerProgress)
                      ElevatedButton.icon(
                        icon: ShadowIcon(
                          Icons.casino_outlined,
                          size: iconSize,
                          color: iconColor,
                          shadowColor: shadowColor,
                          padding: iconPadding,
                        ),
                        onPressed: () => _startGame(GameModeIdentifier.shuffle),
                        label: Text('Shuffle', style: buttonStyle),
                      ),
                    SizedBox(height: spacing),
                    ElevatedButton.icon(
                      icon: ShadowIcon(
                        Icons.help_outline_outlined,
                        size: iconSize,
                        color: iconColor,
                        shadowColor: shadowColor,
                        padding: iconPadding,
                      ),
                      onPressed: widget.onCreditsPressed,
                      label: Text('Credits', style: buttonStyle),
                    ),
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

  Future<void> _startGame(GameModeIdentifier gameModeIdentifier) async {
    await _controller.forward();
    widget.onStartGamePressed(gameModeIdentifier: gameModeIdentifier);
  }

  bool get hasCareerProgress {
    final lastUnlockedLevel = _prefService.getInt(kPrefKeyUnlockedIndex) ?? 0;
    return lastUnlockedLevel > 0;
  }
}
