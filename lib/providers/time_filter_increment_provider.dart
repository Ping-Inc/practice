import 'package:practice/enums/time_filter_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_filter_increment_provider.g.dart';

@riverpod
class TimeFilterIncrement extends _$TimeFilterIncrement {
  @override
  DateTime build(DateTime time) {
    return time;
  }

  void increment(
    TimeFilterEnum timeFilter,
  ) {
    switch (timeFilter) {
      case TimeFilterEnum.year:
        state = state.add(Duration(days: 365));
        break;
      case TimeFilterEnum.month:
        state = state.add(Duration(days: 30));
        break;
      case TimeFilterEnum.dayOfWeek:
        state = state.add(Duration(days: 7));
        break;
      case TimeFilterEnum.dayOfMonth:
        state = state.add(Duration(days: 1));
        break;
    }
  }

  void decrement(
    TimeFilterEnum timeFilter,
  ) {
    switch (timeFilter) {
      case TimeFilterEnum.year:
        state = state.subtract(Duration(days: 365));
        break;
      case TimeFilterEnum.month:
        state = state.subtract(Duration(days: 30));
        break;
      case TimeFilterEnum.dayOfWeek:
        state = state.subtract(Duration(days: 7));
        break;
      case TimeFilterEnum.dayOfMonth:
        state = state.subtract(Duration(days: 1));
        break;
    }
  }
}
