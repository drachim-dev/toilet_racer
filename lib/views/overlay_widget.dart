import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  final Widget child;

  const OverlayWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}