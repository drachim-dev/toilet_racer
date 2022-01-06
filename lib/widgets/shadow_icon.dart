import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShadowIcon extends StatelessWidget {
  final IconData icon;
  final Color color, shadowColor;
  final double size;
  final EdgeInsets padding;

  const ShadowIcon(this.icon,
      {Key key,
      this.color,
      this.shadowColor,
      this.size,
      this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(color: shadowColor.withOpacity(0.6), blurRadius: 4),
          ]),
          child: Icon(icon, color: color, size: size)),
    );
  }
}
