import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toilet_racer/models/level.dart';

import '../models/stage.dart';

class LevelMenu extends StatefulWidget {
  final Future<void> Function(Level level) onPlayPressed;
  final Stage stage;

  const LevelMenu({
    Key? key,
    required this.onPlayPressed,
    required this.stage,
  }) : super(key: key);

  @override
  State<LevelMenu> createState() => _LevelMenuState();
}

class _LevelMenuState extends State<LevelMenu> {
  @override
  Widget build(BuildContext context) {
    final stage = widget.stage;

    const prefixPath = 'assets/images/';
    const spacing = 8.0;

    final theme = Theme.of(context);

    const blur = 10.0;

    final titleStyle = theme.textTheme.headline3;
    final textStyle = theme.textTheme.headline5;

    const Color? unlockedColor = null;
    final lockedColor = Colors.grey.shade700;

    const unlockedOpacity = 0.9;
    const lockedOpacity = 0.7;

    const iconSize = 32.0;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        color: Colors.orangeAccent.withOpacity(0.2),
        child: ListView(
          children: [
            Text(
              'Stage ${stage.index + 1}',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: spacing),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(spacing),
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              children: stage.levels.map((level) {
                final levelIndex = stage.levels.indexOf(level);

                return Stack(
                  children: [
                    Opacity(
                      opacity:
                          level.isUnlocked ? unlockedOpacity : lockedOpacity,
                      child: GridTile(
                        header: Text('${levelIndex + 1}',
                            style: textStyle, textAlign: TextAlign.center),
                        child: Image.asset(
                          '$prefixPath${level.map.filePath}',
                          color: level.isUnlocked ? unlockedColor : lockedColor,
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.saturation,
                        ),
                      ),
                    ),
                    if (level.isLocked)
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.lock, size: iconSize),
                      ),
                    if (level.isUnlocked)
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              widget.onPlayPressed(level);
                            },
                          ),
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
