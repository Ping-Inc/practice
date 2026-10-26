import 'dart:async';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/color_extensions.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/design_system/dusk.dart';
import 'package:practice/providers/app_mode_provider.dart';
import 'package:practice/providers/base_color_provider.dart';
import 'package:practice/providers/passcode_provider.dart';
import 'package:practice/providers/router_provider.dart';
import 'package:practice/utils/backup_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:practice/l10n/app_localizations.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
        await _executeScript(db, i);
      }
    },

    /// if the database exists but the version of the database is different
    /// from the version defined in parameter, onUpgrade will execute all sql requests greater than the old version
    onUpgrade: (db, oldVersion, newVersion) async {
      for (int i = oldVersion + 1; i <= newVersion; i++) {
        await _executeScript(db, i);
      }
    },
  );
}

Future<bool> _columnExists(Database db, String tableName, String columnName) async {
  try {
    final result = await db.rawQuery("PRAGMA table_info($tableName)");
    for (final row in result) {
      if (row['name'] == columnName) {
        return true;
      }
    }
    return false;
  } catch (e) {
    return false;
  }
}

Future<void> _executeScript(Database db, int migrationNumber) async {
  if (migrationNumber == 11) {
    if (!await _columnExists(db, 'pings', 'is_placed')) {
      await db.execute('ALTER TABLE pings ADD COLUMN is_placed BOOLEAN DEFAULT 0');
      print('Added is_placed column');
    } else {
      print('is_placed column already exists, skipping');
    }
    return;
  }
  
  if (migrationNumber == 12) {
    if (!await _columnExists(db, 'pings', 'placed_time')) {
      await db.execute('ALTER TABLE pings ADD COLUMN placed_time INTEGER');
      print('Added placed_time column');
    } else {
      print('placed_time column already exists, skipping');
    }
    return;
  }

  if (migrationNumber == 13) {
    if (!await _columnExists(db, 'pings', 'public_time')) {
      await db.execute('ALTER TABLE pings ADD COLUMN public_time INTEGER');
      print('Added public_time column');
    } else {
      print('public_time column already exists, skipping');
    }
    return;
  }
  
  final script = migrationScripts[migrationNumber];
  if (script != null) {
    await db.execute(script);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait(
      [initializeSharedPrefs(), initializeDb(), BackupUtils.download()]);

  await setBackupSha();
  await clearPasscodeIfReinstalled(prefs, KeychainPasscodeStore());

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
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
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
    final isPublic = ref.watch(isPublicModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // Public mode uses the fixed dusk palette instead of the chosen color.
      theme: isPublic ? _duskTheme() : _themeFor(color),
      // Fade between the two when switching modes.
      themeAnimationDuration: const Duration(milliseconds: 400),
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

ThemeData _buildTheme({
  required Brightness brightness,
  required Color background,
  required Color primary,
  required Color secondary,
  required Color ping,
  required Color pingResonant,
  required Color foreground,
  required Color idInner,
  required Color reply,
}) {
  return ThemeData(
      fontFamily: FontEnum.sfpro.toFontFamily(),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: background,
        secondary: secondary,
        onSecondary: background,
        error: Color.fromRGBO(255, 0, 0, 1),
        onError: primary,
        surface: ping,
        onSurface: primary,
        primaryContainer: background,
        onPrimaryContainer: primary,
        secondaryContainer: pingResonant,
        onSecondaryContainer: primary,
        tertiary: foreground,
        onTertiary: ping,
        tertiaryContainer: idInner,
        onTertiaryContainer: primary,
        errorContainer: Color.fromRGBO(255, 0, 0, 1),
        onErrorContainer: background,
        surfaceContainerHighest: idInner,
        onSurfaceVariant: reply,
        outline: idInner,
        outlineVariant: idInner,
        shadow: secondary,
        scrim: secondary,
        inverseSurface: secondary,
        onInverseSurface: secondary,
        inversePrimary: secondary,
        surfaceTint: secondary,
      ));
}

/// The private-mode theme, built from the color chosen in Settings › Feel.
ThemeData _themeFor(Color color) => _buildTheme(
      brightness: color.brightness,
      background: color.background,
      primary: color.primary,
      secondary: color.secondary,
      ping: color.ping,
      pingResonant: color.pingResonant,
      foreground: color.foreground,
      idInner: color.idInner,
      reply: color.reply,
    );

/// Public mode's fixed grayscale "dusk" theme.
ThemeData _duskTheme() => _buildTheme(
      brightness: Brightness.dark,
      background: Dusk.background,
      primary: Dusk.text,
      secondary: Dusk.secondary,
      ping: Dusk.card,
      // No re-ping glow in public mode.
      pingResonant: Dusk.card,
      foreground: Dusk.outline,
      idInner: Dusk.outline,
      reply: Dusk.outline,
    );
