import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

late Database db;

const double goldenRatio =
    1.6180339887498948482045868343656381177203091798057628621354486227052604628189024497072;

const double spacingOne = 2.2;
const double spacingTwo = spacingOne * goldenRatio;
const double spacingThree = spacingTwo * goldenRatio;
const double spacingFour = spacingThree * goldenRatio;
const double spacingFive = spacingFour * goldenRatio;
const double spacingSix = spacingFive * goldenRatio;
const double spacingSeven = spacingSix * goldenRatio;
const double spacingEight = spacingSeven * goldenRatio;
const double spacingNine = spacingEight * goldenRatio;
const double spacingTen = spacingNine * goldenRatio;

const double spacingXSmall = 10;
const double spacingSmall = 15;
const double spacingMedium = 30;

const double pingButtonSize = 85;
const double modeDialHeight = 20;
const double fadeHeight = 70;

const double cornerRadius = spacingFive;

const Duration duration = Duration(milliseconds: 200);
const Curve curve = Curves.ease;

const double lineHeight = 1.6;

const double tapTarget = 48;

const double thinLine = 0.5;
const double line = thinLine * goldenRatio;

const double smallX = 20;

const int scaffoldTime = 2;

const Map<int, String> migrationScripts = {
  1: '''
  CREATE TABLE pings (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    time INTEGER NOT NULL,
    text TEXT NOT NULL)
  ''',
  2: '''
  CREATE TABLE pings_new (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    time INTEGER NOT NULL,
    text TEXT NOT NULL,
    reply_id INTEGER,
    FOREIGN KEY (reply_id) REFERENCES pings(id)
  )
  ''',
  3: '''
  INSERT INTO pings_new (id, time, text)
  SELECT id, time, text
  FROM pings
  ''',
  4: '''
  DROP TABLE pings
  ''',
  5: '''
  ALTER TABLE pings_new RENAME TO pings
  ''',
  6: '''
  ALTER TABLE pings ADD COLUMN view_count INTEGER DEFAULT 0
  ''',
  7: '''
  ALTER TABLE pings ADD COLUMN resonant_count INTEGER DEFAULT 0
  ''',
  8: '''
  ALTER TABLE pings ADD COLUMN hidden BOOLEAN DEFAULT 0
  ''',
  9: '''
  CREATE UNIQUE INDEX idx_pings_time ON pings(time)
  ''',
  10: '''
  ALTER TABLE pings ADD COLUMN resonant_time INTEGER
  '''
};

const Color themeUIBackgroundBlue = Color.fromRGBO(0, 19, 73, 1);
const Color themeCardBackgroundBlueNewest = Color.fromRGBO(0, 43, 157, 1);
const Color themeCardBackgroundBlueOldest = Color.fromRGBO(1, 28, 107, 1);
const Color themeForegroundBlue = Color.fromRGBO(75, 106, 186, 1);

const Color themeTextActiveBlue = Color.fromRGBO(217, 217, 217, 1);
const Color themeGray = Color.fromRGBO(102, 114, 146, 1);
const Color themePingIDInnerBlue = Color.fromRGBO(81, 113, 198, 1);
const Color themePingIDOuterBlue = Color.fromRGBO(81, 113, 198, 0.25);

final iCloudContainerId = 'iCloud.pingpractice';

late SharedPreferences prefs;
const String sharedPrefsBackupOnKey = "shared_prefs_backup_on_key";

const String sharedPrefsBackupTimeKey = "shared_prefs_backup_time_key";
const String sharedPrefsBackupSha = "shared_prefs_backup_sha";
const String sharedPrefsBrowseMode = "shared_prefs_browse_mode";

Timer? backupTimer;

const String routeHome = 'home';
const String routePingEntry = 'banned';
