import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/ping_provider.dart';

class PingFocusList extends ConsumerWidget {
  const PingFocusList({super.key, required this.pings});

  final List<PingData> pings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.9),
      itemCount: pings.length,
      itemBuilder: (context, i) {
        final ping = ref.watch(pingProvider(pings[i]));

        return Padding(
            padding: EdgeInsets.symmetric(horizontal: spacingThree),
            child: PingCell(
              ping: ping,
              showDate: true,
              showId: true,
              showActions: true,
            ));
      },
    );
  }
}
