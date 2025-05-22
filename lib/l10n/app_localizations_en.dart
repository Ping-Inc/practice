// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get import_pings => 'Import Pings';

  @override
  String pings_imported(Object count) {
    return '$count pings imported';
  }

  @override
  String get loading => 'loading';

  @override
  String get setup_location_alert =>
      'Please allow location for a better experience';
}
