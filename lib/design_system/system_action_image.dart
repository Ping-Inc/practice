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
      required this.height,
      this.color});

  final VoidCallback? onTap;
  final String imagePath;
  final String text;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            imagePath,
            height: height,
            semanticsLabel: text, // Accessibility label
          ),
          SizedBox(
            height: spacingThree,
          ),
          SystemText(
            text: text,
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
