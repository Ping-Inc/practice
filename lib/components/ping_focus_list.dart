import 'package:flutter/material.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';

class PingFocusList extends StatelessWidget {
  const PingFocusList({super.key, required this.pings, required this.scroll});

  final List<PingData> pings;
  final VoidCallback scroll;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.9),
      itemCount: pings.length,
      itemBuilder: (context, i) {
        if (i == pings.length - 1 && pings.length % fetchLimit == 0) {
          scroll();
        }

        return Padding(
            padding: EdgeInsets.symmetric(horizontal: spacingThree),
            child: PingCell(
              inputPing: pings[i],
              showDate: true,
              showId: true,
              showActions: true,
            ));
      },
    );
  }
}
