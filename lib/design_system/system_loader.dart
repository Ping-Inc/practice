import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class SystemLoader extends StatefulWidget {
  const SystemLoader({super.key, this.color});

  final Color? color;

  @override
  State<SystemLoader> createState() => _SystemLoaderState();
}

class _SystemLoaderState extends State<SystemLoader> {
  String dots = '.';
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: animationDuration),
        (Timer t) {
      if (mounted) {
        setState(() {
          if (dots.length > 2) {
            dots = '.';
          } else {
            dots += '.';
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(spacingFive),
      child: Text('Loading$dots'),
    ));
  }
}
