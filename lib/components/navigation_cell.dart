import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';

class NavigationCell extends StatelessWidget {
  const NavigationCell(
      {super.key,
      required this.onTap,
      required this.label,
      required this.value});

  final VoidCallback onTap;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SystemTap(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(spacingFive),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SystemText(
                color: gray,
                text: label,
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: spacingSeven,
                  ),
                  Expanded(
                      child: SystemText(
                    align: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).colorScheme.primary,
                    text: value,
                  )),
                  SizedBox(
                    width: spacingFive,
                  ),
                  Icon(
                    PhosphorIcons.caret_right,
                    color: Theme.of(context).colorScheme.primary,
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
