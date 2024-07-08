import 'package:practice/constants.dart';
import 'package:practice/enums/backup_frequency_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_frequency_provider.g.dart';

@riverpod
class BackupFrequency extends _$BackupFrequency {
  @override
  BackupFrequencyEnum build() {
    return prefs.getString(sharedPrefsBackupFrequencyKey) == null
        ? BackupFrequencyEnum.hourly
        : BackupFrequencyEnum.values.firstWhere((e) =>
            e.toString() == prefs.getString(sharedPrefsBackupFrequencyKey)!);
  }

  void setFrequency(BackupFrequencyEnum frequency) {
    prefs.setString(sharedPrefsBackupFrequencyKey, frequency.toString());

    state = frequency;
  }
}
