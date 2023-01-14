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
  final VoidCallback onSelectLevelsPressed;
  final VoidCallback onCreditsPressed;
  final VoidCallback onLeaderboardPressed;

  const StartMenu({
    Key? key,
    required this.onPlayPressed,
    required this.onSelectLevelsPressed,
    required this.onCreditsPressed,
    required this.onLeaderboardPressed,
  }) : super(key: key);

  @override
  _StartMenuState createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleStyle = theme.textTheme.headline1!.copyWith(color: Colors.brown);

    const spacing = 64.0;

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
                    const SizedBox(height: spacing * 2),
                    _buildButton(
                      icon: Icons.play_circle_outline_outlined,
                      label: hasCareerProgress
                          ? S.of(context).pageStartContinueButtonText
                          : S.of(context).pageStartPlayButtonText,
                      onPressed: () => _startGame(GameModeIdentifier.career),
                    ),
                    if (hasCareerProgress)
                      _buildButton(
                        icon: Icons.landscape_outlined,
                        label: 'Levels',
                        onPressed: widget.onSelectLevelsPressed,
                      ),
                    if (hasCareerProgress)
                      _buildButton(
                        icon: Icons.casino_outlined,
                        label: S.of(context).pageStartShuffleButtonText,
                        onPressed: () => _startGame(GameModeIdentifier.shuffle),
                      ),
                    _buildButton(
                      icon: Icons.help_outline_outlined,
                      label: S.of(context).pageStartCreditsButtonText,
                      onPressed: widget.onCreditsPressed,
                    ),
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
    final unlockedLevelIndex =
        _prefService.getInt(kPrefKeyUnlockedLevelIndex) ?? 0;
    return unlockedLevelIndex > 0;
  }

  ShadowIcon _buildShadowIcon(IconData icon, {required double iconSize}) {
    const iconColor = secondaryColor;
    const shadowColor = primaryColor;
    const iconPadding = EdgeInsets.only(right: 16);

    return ShadowIcon(
      icon,
      size: iconSize,
      color: iconColor,
      shadowColor: shadowColor,
      padding: iconPadding,
    );
  }

  Widget _buildButton(
      {required IconData icon,
      required String label,
      required Function() onPressed}) {
    final theme = Theme.of(context);
    final buttonStyle = theme.textTheme.headline2!;
    final iconSize = buttonStyle.fontSize! - 8;
    const spacing = 32.0;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: spacing),
        child: ElevatedButton.icon(
          icon: _buildShadowIcon(icon, iconSize: iconSize),
          onPressed: onPressed,
          label: Text(label, style: buttonStyle),
        ));
  }
}
