import 'package:practice/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_provider.g.dart';

@riverpod
class Onboarding extends _$Onboarding {
  @override
  bool build() {
    return prefs.getBool(sharedPrefsOnboarded) ?? false;
  }

  void complete() {
    prefs.setBool(sharedPrefsOnboarded, true);
    state = true;
  }
}
