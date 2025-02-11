import 'package:practice/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_backup_on_provider.g.dart';

@riverpod
class CloudBackupOn extends _$CloudBackupOn {
  @override
  bool build() {
    return prefs.getBool(sharedPrefsBackupOnKey) ?? true;
  }

  void toggle() {
    prefs.setBool(sharedPrefsBackupOnKey, !state);
    state = !state;
  }
}
