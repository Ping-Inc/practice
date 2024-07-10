import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:practice/constants.dart';
import 'package:practice/extensions/date_time_enum_extensions.dart';
import 'package:practice/extensions/theme_mode_enum_extensions.dart';
import 'package:practice/pages/home_page.dart';
import 'package:practice/providers/theme_mode_provider.dart';
import 'package:practice/providers/time_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<Database> initDatabase() async {
  // count the number of scripts to define the version of the database
  int nbrMigrationScripts = migrationScripts.length;
  return openDatabase(
    join(await getDatabasesPath(), "practice.db"),
    version: nbrMigrationScripts,
    // if the database does not exist, onCreate executes all the sql requests of the "migrationScripts" map
    onCreate: (Database db, int version) async {
      for (int i = 1; i <= nbrMigrationScripts; i++) {
        final script = migrationScripts[i];
        if (script != null) {
          await db.execute(script);
        }
      }
    },

    /// if the database exists but the version of the database is different
    /// from the version defined in parameter, onUpgrade will execute all sql requests greater than the old version
    onUpgrade: (db, oldVersion, newVersion) async {
      for (int i = oldVersion + 1; i <= newVersion; i++) {
        final script = migrationScripts[i];
        if (script != null) {
          await db.execute(script);
        }
      }
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  db = await initDatabase();
  // await initializeBackupService();
  // await backUpDB();

  runApp(
    ProviderScope(
      child: PingPractice(),
    ),
  );
}

// Future<void> initializeBackupService() async {
//   final service = FlutterBackgroundService();

//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
//       autoStart: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//       onBackground: (service) async {
//         // iOS will stop the background service after 30 seconds.
//         // You can do any task within 30 seconds.
//         return true;
//       },
//     ),
//   );

//   service.startService();
// }

// void onStart(ServiceInstance service) async {
//   Timer? timer = null;

//   final enabled = prefs.getBool(sharedPrefsBackupOnKey) ?? false;

//   if (enabled) {
//     final frequency = prefs.getString(sharedPrefsBackupFrequencyKey) == null
//         ? BackupFrequencyEnum.hourly
//         : BackupFrequencyEnum.values.firstWhere((e) =>
//             e.toString() == prefs.getString(sharedPrefsBackupFrequencyKey)!);

//     startTimer(timer, frequency.duration());
//   }

//   service.on('refreshTimer').listen((event) {
//     refreshTimer(timer);
//   });
// }

// void refreshTimer(Timer? timer) async {
//   final enabled = prefs.getBool(sharedPrefsBackupOnKey) ?? false;

//   if (enabled) {
//     final frequency = prefs.getString(sharedPrefsBackupFrequencyKey) == null
//         ? BackupFrequencyEnum.hourly
//         : BackupFrequencyEnum.values.firstWhere((e) =>
//             e.toString() == prefs.getString(sharedPrefsBackupFrequencyKey)!);

//     stopTimer(timer);
//     startTimer(timer, frequency.duration());
//   } else {
//     stopTimer(timer);
//   }
// }

class PingPractice extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(timeProvider, (previous, next) {
      if (previous != null &&
          previous.value != null &&
          next.value != null &&
          previous.value!.themeMode() != next.value!.themeMode()) {
        ref.invalidate(themeModeProvider);
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeModeProvider).data(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
