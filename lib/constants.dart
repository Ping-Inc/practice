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

const double cornerRadius = spacingFive;

const Duration duration = Duration(milliseconds: 200);
const Curve curve = Curves.ease;

const double tapTarget = 48;

const double thinLine = 0.5;
const double line = thinLine * goldenRatio;

const double smallX = 20;

const int fetchLimit = 66;

const int scaffoldTime = 2;

const Map<int, String> migrationScripts = {
  1: '''CREATE TABLE pings (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              time INTEGER NOT NULL,
              text TEXT NOT NULL)
              '''
};

const Color themeBlack = Color.fromRGBO(0, 0, 0, 1);
const Color themeWhite = Color.fromRGBO(255, 255, 255, 1);
const Color themeBlue = Color.fromRGBO(17, 0, 255, 1);
const Color themeYellow = Color.fromRGBO(253, 246, 227, 1);

const Color pureRed = Color.fromRGBO(255, 0, 0, 1);

const Color gray = Color.fromRGBO(180, 180, 180, 1);

const Color lightSecondary = Color.fromRGBO(0, 0, 0, 0.06);
const Color darkSecondary = Color.fromRGBO(255, 255, 255, 0.1);
const Color blueSecondary = Color.fromRGBO(32, 0, 189, 1);

const double fontSmall = 12;

late SharedPreferences prefs;
const String sharedPrefsBackupOnKey = "shared_prefs_backup_on_key";
const String sharedPrefsBackupFrequencyKey =
    "shared_prefs_backup_frequency_key";
const String sharedPrefsBackupPathKey = "shared_prefs_backup_path_key";
const String sharedPrefsBackupTimeKey = "shared_prefs_backup_time_key";

Timer? backupTimer;

const String routeHome = 'home';
const String routePingEntry = 'banned';
