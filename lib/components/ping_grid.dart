import 'package:flutter/material.dart';
import 'package:practice/components/ping_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';

class PingGrid extends StatelessWidget {
  const PingGrid({super.key, required this.pings, this.showId = false});

  final List<PingData> pings;
  final bool showId;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification &&
              FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
          return true;
        },
        child: GridView.builder(
          padding: EdgeInsets.only(bottom: spacingMedium),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: spacingFour,
            crossAxisSpacing: spacingFour,
            childAspectRatio: 1,
          ),
          itemCount: pings.length,
          itemBuilder: (context, i) {
            return PingCell(inputPing: pings[i], showId: showId);
          },
        ));
  }
}
