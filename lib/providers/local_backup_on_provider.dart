import 'package:practice/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_backup_on_provider.g.dart';

@riverpod
class LocalBackupOn extends _$LocalBackupOn {
  @override
  bool build() {
    return prefs.getBool(sharedPrefsBackupOnKey) ?? true;
  }

  void toggle() {
    prefs.setBool(sharedPrefsBackupOnKey, !state);
    state = !state;
  }
}
