import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class WeatherCell extends StatelessWidget {
  const WeatherCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("weather ☀️",
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: fontSmall));
  }
}
