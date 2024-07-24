import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class SystemBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SystemTap(
        onTap: context.pop,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(PhosphorIcons.caret_left),
            SizedBox(
              width: spacingTwo,
            ),
            SystemText(text: 'All Pings')
          ],
        ));
  }
}
