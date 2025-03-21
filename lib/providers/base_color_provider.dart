import 'dart:ui';

import 'package:practice/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_color_provider.g.dart';

@riverpod
class BaseColor extends _$BaseColor {
  @override
  Color build() {
    int? colorValue = prefs.getInt(sharedPrefsColor);

    return colorValue == null
        ? Color.fromRGBO(218, 233, 21, 1)
        : Color(colorValue);
  }

  void setColor(Color color) {
    if (state != color) {
      prefs.setInt(sharedPrefsColor, color.toARGB32());
      state = color;
    }
  }
}
