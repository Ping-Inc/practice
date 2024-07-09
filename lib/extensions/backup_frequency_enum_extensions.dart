import 'package:flutter/material.dart';
import 'package:practice/enums/backup_frequency_enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension StringParsing on BackupFrequencyEnum {
  String title(BuildContext context) {
    switch (this) {
      case BackupFrequencyEnum.hourly:
        return AppLocalizations.of(context)!.hourly;
      case BackupFrequencyEnum.daily:
        return AppLocalizations.of(context)!.daily;
      case BackupFrequencyEnum.weekly:
        return AppLocalizations.of(context)!.weekly;
      case BackupFrequencyEnum.monthly:
        return AppLocalizations.of(context)!.monthly;
    }
  }
}

extension DurationParsing on BackupFrequencyEnum {
  Duration duration() {
    switch (this) {
      case BackupFrequencyEnum.hourly:
        return Duration(hours: 1);
      case BackupFrequencyEnum.daily:
        return Duration(days: 1);
      case BackupFrequencyEnum.weekly:
        return Duration(days: 7);
      case BackupFrequencyEnum.monthly:
        return Duration(days: 30);
    }
  }
}
