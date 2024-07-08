import 'package:practice/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_path_provider.g.dart';

@riverpod
class BackupPath extends _$BackupPath {
  @override
  String? build() {
    return prefs.getString(sharedPrefsBackupPathKey);
  }

  void setPath(String path) {
    prefs.setString(sharedPrefsBackupPathKey, path);
    state = path;
  }
}
