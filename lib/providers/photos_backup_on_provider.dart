import 'package:practice/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photos_backup_on_provider.g.dart';

@riverpod
class PhotosBackupOn extends _$PhotosBackupOn {
  @override
  bool build() {
    return prefs.getBool(sharedPrefsPhotosBackupOnKey) ?? false;
  }

  void enable() {
    prefs.setBool(sharedPrefsPhotosBackupOnKey, true);
    state = true;
  }

  void disable() {
    prefs.setBool(sharedPrefsPhotosBackupOnKey, false);
    state = false;
  }
}
