import 'dart:async';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/theme_mode_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/providers/current_day_of_month_provider.dart';
import 'package:practice/providers/current_day_of_week_provider.dart';
import 'package:practice/providers/current_month_provider.dart';
import 'package:practice/providers/current_week_provider.dart';
import 'package:practice/providers/current_year_provider.dart';
import 'package:practice/providers/router_provider.dart';
import 'package:practice/providers/theme_mode_provider.dart';
import 'package:practice/providers/time_provider.dart';
import 'package:practice/utils/backup_utils.dart';
import 'package:practice/utils/theme_utils.dart';
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

  await initializeSharedPrefs();
  db = await initDatabase();

  if (await prefs.getString(sharedPrefsBackupSha) == null) {
    await prefs.setString(sharedPrefsBackupSha, generateRandomSha());
  }

  BackupUtils.download();

  runApp(
    ProviderScope(
      child: PingPractice(),
    ),
  );
}

String generateRandomSha() {
  final random = Random();
  final bytes = List<int>.generate(20, (_) => random.nextInt(256));
  final sha1Hash = sha1.convert(bytes);
  return sha1Hash.toString().substring(0, 5);
}

Future<void> initializeDb() async {
  try {
    db = await initDatabase();
  } catch (e) {
    print('Error initializing database: $e');
  }
}

Future<void> initializeSharedPrefs() async {
  prefs = await SharedPreferences.getInstance();
}

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

      if (previous != null &&
          previous.value != null &&
          next.value != null &&
          previous.value!.weekday != next.value!.weekday) {
        ref.invalidate(currentDayOfWeekProvider);
        ref.invalidate(currentDayOfMonthProvider);
      }

      if (previous != null &&
          previous.value != null &&
          next.value != null &&
          previous.value!.year != next.value!.year) {
        ref.invalidate(currentYearProvider);
      }

      if (previous != null &&
          previous.value != null &&
          next.value != null &&
          previous.value!.month != next.value!.month) {
        ref.invalidate(currentMonthProvider);
      }

      if (previous != null &&
          previous.value != null &&
          next.value != null &&
          next.value!.weekday == 7 &&
          previous.value!.weekday == 6) {
        ref.invalidate(currentWeekProvider);
      }
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeUtils.themeForThemeEnum(Brightness.dark, ThemeModeEnum.evening),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: ref.watch(routerProvider),
    );
  }
}
