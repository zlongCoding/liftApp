import 'package:flutter/material.dart';

class LiftIcon extends StatelessWidget {
  final int code;
  final Color color;
  final double size;
  final String family;

  LiftIcon(
      {@required this.code,
      this.color = Colors.grey,
      this.size = 20.0,
      this.family = 'Blog'});
  @override
  Widget build(BuildContext context) {
    return Icon(IconData(code, fontFamily: family), color: color, size: size);
  }
}
