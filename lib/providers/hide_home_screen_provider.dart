import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hide_home_screen_provider.g.dart';

@riverpod
class HideHomeScreenProvider extends _$HideHomeScreenProvider {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    if (state == false) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }

    state = !state;
  }
}
