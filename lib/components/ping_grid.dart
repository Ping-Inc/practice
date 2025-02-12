import 'package:flutter/material.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';

class PingGrid extends StatelessWidget {
  const PingGrid(
      {super.key,
      required this.pings,
      required this.scroll,
      required this.sliver});

  final List<PingData> pings;
  final VoidCallback scroll;
  final bool sliver;

  @override
  Widget build(BuildContext context) {
    return sliver
        ? SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: spacingFour,
              crossAxisSpacing: spacingFour,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                if (i == pings.length - 1 && pings.length % fetchLimit == 0) {
                  scroll();
                }

                return PingCell(inputPing: pings[i]);
              },
              childCount: pings.length,
            ),
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: spacingFour,
              crossAxisSpacing: spacingFour,
              childAspectRatio: 1,
            ),
            itemCount: pings.length,
            itemBuilder: (context, i) {
              if (i == pings.length - 1 && pings.length % fetchLimit == 0) {
                scroll();
              }

              return PingCell(inputPing: pings[i]);
            },
          );
  }
}
