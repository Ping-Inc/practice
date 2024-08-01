import 'package:practice/enums/theme_mode_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mode_filter_increment_provider.g.dart';

@riverpod
class ModeFilterIncrement extends _$ModeFilterIncrement {
  @override
  ThemeModeEnum build(DateTime time) {
    return time.themeMode();
  }

  void increment() {
    switch (state) {
      case ThemeModeEnum.morning:
        state = ThemeModeEnum.afternoon;
        break;
      case ThemeModeEnum.afternoon:
        state = ThemeModeEnum.evening;
        break;
      case ThemeModeEnum.evening:
        state = ThemeModeEnum.night;
        break;
      case ThemeModeEnum.night:
        state = ThemeModeEnum.morning;
        break;
    }
  }

  void decrement() {
    switch (state) {
      case ThemeModeEnum.morning:
        state = ThemeModeEnum.night;
        break;
      case ThemeModeEnum.afternoon:
        state = ThemeModeEnum.morning;
        break;
      case ThemeModeEnum.evening:
        state = ThemeModeEnum.afternoon;
        break;
      case ThemeModeEnum.night:
        state = ThemeModeEnum.evening;
        break;
    }
  }
}
