import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/providers/ping_id_provider.dart';
import 'package:practice/providers/time_provider.dart';

class TimeRow extends ConsumerWidget {
  const TimeRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(timeProvider)) {
      AsyncData(value: final now) =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            DateFormat('EEEE, MMMM d, y').format(now),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            DateFormat('h:mma').format(now).toLowerCase(),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          )
        ]),
      _ => SizedBox.shrink()
    };
  }
}
