import 'package:practice/enums/theme_mode_enum.dart';

extension ThemeModesEnumExtension on DateTime {
  ThemeModeEnum themeMode() {
    final hour = this.hour;
    if (hour >= 6 && hour < 11) {
      return ThemeModeEnum.morning;
    } else if (hour >= 11 && hour < 17) {
      return ThemeModeEnum.afternoon;
    } else if (hour >= 17 && hour < 22) {
      return ThemeModeEnum.evening;
    } else {
      return ThemeModeEnum.night;
    }
  }
}
