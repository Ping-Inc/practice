import 'package:flutter/material.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SystemActionImage extends StatelessWidget {
  const SystemActionImage(
      {super.key,
      required this.onTap,
      required this.imagePath,
      required this.text,
      required this.height});

  final VoidCallback onTap;
  final String imagePath;
  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: spacingThree, vertical: spacingFour),
          child: Column(
            children: [
              SvgPicture.asset(
                imagePath,
                height: height,
                semanticsLabel: text, // Accessibility label
              ),
              SizedBox(
                width: spacingFive,
              ),
              SystemText(text: text),
            ],
          ),
        ));
  }
}
