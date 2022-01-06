import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toilet_racer/app/constants.dart';
import 'package:toilet_racer/app/locator.dart';
import 'package:toilet_racer/app/theme.dart';
import 'package:toilet_racer/generated/l10n.dart';
import 'package:toilet_racer/race_game_mode.dart';
import 'package:toilet_racer/views/flip_widget.dart';
import 'package:toilet_racer/widgets/shadow_icon.dart';

class StartMenu extends StatefulWidget {
  final Future<void> Function(GameModeIdentifier identifier) onPlayPressed;
  final VoidCallback onCreditsPressed;
  final VoidCallback onLeaderboardPressed;

  const StartMenu({
    Key key,
    @required this.onPlayPressed,
    @required this.onCreditsPressed,
    @required this.onLeaderboardPressed,
  }) : super(key: key);

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
      duration: const Duration(seconds: 1),
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

    const iconColor = secondaryColor;
    const shadowColor = primaryColor;
    final iconSize = buttonStyle.fontSize - 8;
    const iconPadding = EdgeInsets.only(right: 16);

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
                    Text(S.of(context).appTitle, style: titleStyle),
                    const SizedBox(height: spacing * 3),
                    ElevatedButton.icon(
                        icon: ShadowIcon(
                          Icons.play_circle_outline_outlined,
                          size: iconSize,
                          color: iconColor,
                          shadowColor: shadowColor,
                          padding: iconPadding,
                        ),
                        onPressed: () => _startGame(GameModeIdentifier.career),
                        label: Text(
                            hasCareerProgress
                                ? S.of(context).pageStartContinueButtonText
                                : S.of(context).pageStartPlayButtonText,
                            style: buttonStyle)),
                    const SizedBox(height: spacing),
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
                        label: Text(S.of(context).pageStartShuffleButtonText,
                            style: buttonStyle),
                      ),
                    const SizedBox(height: spacing),
                    ElevatedButton.icon(
                      icon: ShadowIcon(
                        Icons.help_outline_outlined,
                        size: iconSize,
                        color: iconColor,
                        shadowColor: shadowColor,
                        padding: iconPadding,
                      ),
                      onPressed: widget.onCreditsPressed,
                      label: Text(S.of(context).pageStartCreditsButtonText,
                          style: buttonStyle),
                    ),
                    const SizedBox(height: spacing),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _startGame(GameModeIdentifier identifier) async {
    await _controller.forward();
    await widget.onPlayPressed(identifier);
  }

  bool get hasCareerProgress {
    final unlockedLevelIndex = _prefService.getInt(kPrefKeyUnlockedIndex) ?? 0;
    return unlockedLevelIndex > 0;
  }
}
