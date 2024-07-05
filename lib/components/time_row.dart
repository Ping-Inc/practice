import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/time_provider.dart';

class TimeRow extends ConsumerWidget {
  const TimeRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(timeProvider)) {
      AsyncData(value: final now) => Text(
          DateFormat('MMMM d, y, h:mma').format(now),
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: fontSmall),
        ),
      _ => SizedBox.shrink()
    };
  }
}
