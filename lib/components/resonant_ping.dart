import 'package:flutter/material.dart';
import 'package:practice/data/ping_data.dart';

class ResonantPing extends StatelessWidget {
  const ResonantPing({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 11,
      width: 11,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
    );
  }
}
