import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hide_home_screen_provider.g.dart';

@riverpod
class HideHomeScreenProvider extends _$HideHomeScreenProvider {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
