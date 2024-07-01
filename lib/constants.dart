import 'package:flutter/material.dart';
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

const Color black3 = Color.fromRGBO(0, 0, 0, 1);
const Color white3 = Color.fromRGBO(255, 255, 255, 1);
const Color blue3 = Color.fromRGBO(43, 54, 193, 1);
const Color yellow3 = Color.fromRGBO(253, 246, 227, 1);

const Color black2 = Color.fromRGBO(33, 33, 33, 1);
const Color white2 = Color.fromRGBO(232, 232, 232, 1);
const Color blue2 = Color.fromRGBO(54, 66, 192, 1);
const Color yellow2 = Color.fromRGBO(238, 232, 213, 1);

const Color black1 = Color.fromRGBO(66, 66, 66, 1);
const Color white1 = Color.fromRGBO(209, 209, 209, 1);
const Color blue1 = Color.fromRGBO(110, 117, 194, 1);
const Color yellow1 = Color.fromRGBO(147, 161, 161, 1);

const Color pureRed = Color.fromRGBO(255, 0, 0, 1);

const Color blackInputBackgroundColor = Color.fromRGBO(36, 36, 36, 1);
