import 'package:flutter/material.dart';

class SystemCircle extends StatelessWidget {
  const SystemCircle({Key? key, this.color = Colors.grey}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 19,
      width: 19,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
