import 'package:flutter/material.dart';
import 'package:practice/constants.dart';

class SystemDivider extends StatelessWidget {
  const SystemDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thinLine,
      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.666),
    );
  }
}
