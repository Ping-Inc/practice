import 'package:flutter/material.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class SystemActionIcon extends StatelessWidget {
  const SystemActionIcon(
      {super.key, required this.onTap, required this.icon, required this.text});

  final VoidCallback onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: spacingThree, vertical: spacingFour),
          child: Column(
            children: [
              Icon(icon),
              SizedBox(
                width: spacingTwo,
              ),
              SystemText(text: text),
            ],
          ),
        ));
  }
}
