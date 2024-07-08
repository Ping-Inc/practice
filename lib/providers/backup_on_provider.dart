import 'package:practice/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_on_provider.g.dart';

@riverpod
class BackupOn extends _$BackupOn {
  @override
  bool build() {
    return prefs.getBool(sharedPrefsBackupOnKey) ?? false;
  }

  void toggle() {
    prefs.setBool(sharedPrefsBackupOnKey, !state);
    state = !state;
  }
}
