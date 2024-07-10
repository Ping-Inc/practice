import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/input_ping_text_cell.dart';
import 'package:practice/components/neighborhood_cell.dart';
import 'package:practice/components/meta_data/ping_id_cell.dart';
import 'package:practice/components/meta_data/time_cell.dart';
import 'package:practice/components/meta_data/weather_cell.dart';
import 'package:practice/constants.dart';

class CurrentPingCell extends ConsumerWidget {
  const CurrentPingCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: spacingSeven, vertical: spacingFive),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [PingIdCell(), TimeCell()]),
              SizedBox(height: spacingThree),
              AspectRatio(aspectRatio: 1, child: InputPingTextCell()),
              SizedBox(height: spacingThree),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [NeighborhoodCell(), WeatherCell()],
              )
            ])));
  }
}
