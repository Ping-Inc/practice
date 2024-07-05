import 'package:flutter/material.dart';

class NeighborhoodCell extends StatelessWidget {
  const NeighborhoodCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("weather ☀️  neighborhood",
        style: TextStyle(color: Theme.of(context).colorScheme.secondary));
  }
}
