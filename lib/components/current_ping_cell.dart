import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/neighborhood_cell.dart';
import 'package:practice/components/ping_id_cell.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/components/time_row.dart';
import 'package:practice/components/weather_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/current_ping_provider.dart';

class CurrentPingCell extends ConsumerWidget {
  const CurrentPingCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: spacingEight, vertical: spacingFive),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [PingIdCell(), TimeRow()]),
              SizedBox(height: spacingThree),
              AspectRatio(
                  aspectRatio: 1,
                  child:
                      ResizingTextCell(text: ref.watch(currentPingProvider))),
              SizedBox(height: spacingThree),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [NeighborhoodCell(), WeatherCell()],
              )
            ])));
  }
}
