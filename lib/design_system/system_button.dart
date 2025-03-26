import 'package:flutter/material.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class SystemButton extends StatelessWidget {
  const SystemButton({super.key, required this.onTap, this.icon, this.text});

  final VoidCallback onTap;
  final IconData? icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: spacingThree, vertical: spacingFour),
          child: Row(
            children: [
              if (icon != null) Icon(icon),
              if (icon != null && text != null)
                SizedBox(
                  width: spacingTwo,
                ),
              if (text != null) SystemText(text: text!),
            ],
          ),
        ));
  }
}
