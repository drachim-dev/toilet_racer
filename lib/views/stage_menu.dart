import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:toilet_racer/models/level.dart';
import 'package:toilet_racer/models/stage.dart';

import '../app/locator.dart';
import '../repos/stage_repository.dart';

class StageMenu extends StatefulWidget {
  final void Function(Stage stage) onStageSelected;

  const StageMenu({Key? key, required this.onStageSelected}) : super(key: key);

  @override
  State<StageMenu> createState() => _StageMenuState();
}

class _StageMenuState extends State<StageMenu> {
  final StageRepository _stageRepository = locator<StageRepository>();
  late final List<Stage> _stages;

  @override
  void initState() {
    super.initState();

    _stages = _stageRepository.getAllStages();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.headline5;

    const itemSpacing = EdgeInsets.symmetric(horizontal: 0);
    const titlePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlutterCarousel(
          options: CarouselOptions(
            height: 320.0,
            viewportFraction: 0.7,
            showIndicator: true,
            floatingIndicator: false,
            slideIndicator: CircularWaveSlideIndicator(),
            initialPage: 0,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
          ),
          items: List.generate(_stages.length, (index) {
            final stage = _stages[index];
            final isLocked = stage.levels.first.isLocked;

            return Builder(
              builder: (context) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  color: Colors.amber.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: isLocked
                        ? _buildStageContainer(context, itemSpacing,
                            titlePadding, index, stage, textStyle, isLocked)
                        : InkWell(
                      child: _buildStageContainer(context, itemSpacing, titlePadding, index, stage, textStyle, isLocked),
                      onTap: () {
                        widget.onStageSelected(stage);
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Container _buildStageContainer(BuildContext context, EdgeInsets itemSpacing, EdgeInsets titlePadding, int index, Stage stage, TextStyle? textStyle, bool isLocked) {
    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: itemSpacing,
                      padding: titlePadding,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Text(
                            '${index + 1}. ${stage.name}',
                            style: textStyle,
                          ),
                          if (isLocked)
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.lock, size: 56),
                            ),
                        ],
                      ),
                    );
  }
}
