import 'package:flutter/material.dart';
import 'package:practice/components/resonant_ping.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';

class PingCell extends StatelessWidget {
  const PingCell({super.key, required this.ping, required this.mode});

  final Ping ping;
  final BrowseEnum mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(spacingSix),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(spacingFour),
      ),
      child: Row(children: [
        SystemText(
          text: ping.text,
          color: Theme.of(context).colorScheme.primary,
        ),
        ResonantPing(ping: ping)
      ]),
    );
  }
}
