import 'package:flutter/material.dart';
import 'package:practice/components/resizing_text.dart';
import 'package:practice/constants.dart';

class ResizingTextCell extends StatelessWidget {
  const ResizingTextCell(
      {super.key, required this.text, this.color = Colors.grey});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: line,
          ),
        ),
        padding: EdgeInsets.all(spacingFour),
        child: ResizingText(text: text));
  }
}
