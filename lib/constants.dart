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

const int animationDuration = 200;
const int slowAnimationDuration = 400;

const double tapTarget = 48;

const double thinLine = 0.25;
const double line = thinLine * goldenRatio;

const double smallX = 20;

const int fetchLimit = 66;
