import 'dart:async';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:practice/constants.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';
import 'package:practice/providers/router_provider.dart';
import 'package:practice/utils/backup_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> setBackupSha() async {
  if (await prefs.getString(sharedPrefsBackupSha) == null) {
    await prefs.setString(sharedPrefsBackupSha, generateRandomSha());
  }
}

Future<Database> _initDatabase() async {
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

  await Future.wait(
      [initializeSharedPrefs(), initializeDb(), BackupUtils.download()]);

  await setBackupSha();

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
    db = await _initDatabase();
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
    final color = ref.watch(baseColorProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: color.background,
          colorScheme: ColorScheme(
            brightness: color.brightness,
            primary: color.primary,
            onPrimary: color.background,
            secondary: color.secondary,
            onSecondary: Colors.white,
            error: Color.fromRGBO(255, 0, 0, 1),
            onError: Colors.white,
            surface: color.ping,
            onSurface: color.primary,
            primaryContainer: color.background,
            onPrimaryContainer: color.primary,
            secondaryContainer: color.background,
            onSecondaryContainer: color.primary,
            tertiary: color.foreground,
            onTertiary: color.ping,
            tertiaryContainer: color.idOuter,
            onTertiaryContainer: color.primary,
            errorContainer: Color.fromRGBO(255, 0, 0, 1),
            onErrorContainer: Colors.white,
            surfaceContainerHighest: color.idInner,
            onSurfaceVariant: color.primary,
            outline: color.idInner,
            outlineVariant: color.idOuter,
            shadow: color.secondary,
            scrim: color.secondary,
            inverseSurface: color.secondary,
            onInverseSurface: color.secondary,
            inversePrimary: color.secondary,
            surfaceTint: color.secondary,
          )),
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
