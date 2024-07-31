import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/filter_incrementer.dart';
import 'package:practice/enums/time_filter_enum.dart';
import 'package:practice/providers/time_filter_increment_provider.dart';
import 'package:practice/utils/string_utils.dart';

class TimeFilterIncrementer extends ConsumerWidget {
  const TimeFilterIncrementer(
      {super.key, required this.timeEnum, required this.time});

  final TimeFilterEnum timeEnum;
  final DateTime time;

  String titleFromTimeAndFilter(DateTime currentTime) {
    switch (timeEnum) {
      case TimeFilterEnum.year:
        return DateFormat('yyyy').format(currentTime);
      case TimeFilterEnum.month:
        return DateFormat('MMMM').format(currentTime);
      case TimeFilterEnum.dayOfMonth:
        return StringUtils.getDayWithSuffix(currentTime.day);
      case TimeFilterEnum.dayOfWeek:
        return "${DateFormat('EEEE').format(currentTime)}s";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(timeFilterIncrementProvider(time));

    return FilterIncrementer(
      title: titleFromTimeAndFilter(currentTime),
      increment: () {
        ref
            .read(timeFilterIncrementProvider(time).notifier)
            .increment(timeEnum);
      },
      decrement: () {
        ref
            .read(timeFilterIncrementProvider(time).notifier)
            .decrement(timeEnum);
      },
    );
  }
}
