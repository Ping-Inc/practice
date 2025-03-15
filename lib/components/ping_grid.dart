import 'package:flutter/material.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_grid.dart';

class PingGrid extends StatelessWidget {
  const PingGrid({
    super.key,
    required this.pings,
    this.showId = false,
    this.sortByResonance = false,
  });

  final List<PingData> pings;
  final bool showId;
  final bool sortByResonance;
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
        child: SystemGrid(
          pings: pings,
          showId: showId,
          sortByResonance: sortByResonance,
        ));
  }
}
