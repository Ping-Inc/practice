import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/utils/location_utils.dart';

class NeighborhoodCell extends StatelessWidget {
  const NeighborhoodCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("weather ☀️  neighborhood",
        style: TextStyle(color: Theme.of(context).colorScheme.secondary));
    return switch (LocationUtils.getNeighborhood(context)) {
      AsyncData(value: final neighborhood) => Text(neighborhood,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      _ => SizedBox.shrink()
    };
  }
}
