import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_button.dart';

class PingActionRow extends ConsumerWidget {
  const PingActionRow({super.key, required this.ping});

  final Ping ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: spacingFive, vertical: spacingTwo),
        child: Row(
          children: [
            Expanded(
                child: Row(
              children: [
                SystemButton(
                    onTap: () {}, icon: PhosphorIcons.eye_closed, text: "Hide"),
                SizedBox(
                  width: spacingThree,
                ),
                SystemButton(
                    onTap: () {},
                    icon: PhosphorIcons.arrow_arc_left,
                    text: "Reply"),
              ],
            )),
            SystemButton(
                onTap: () {},
                icon: PhosphorIcons.sparkle,
                text: ping.resonantCount.toString()),
          ],
        ));
  }
}
