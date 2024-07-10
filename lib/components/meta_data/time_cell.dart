import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/meta_data_text.dart';
import 'package:practice/providers/time_provider.dart';

class TimeCell extends ConsumerWidget {
  const TimeCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(timeProvider)) {
      AsyncData(value: final now) =>
        MetaDataText(text: DateFormat('MMMM d, y').format(now)),
      _ => SizedBox.shrink()
    };
  }
}
