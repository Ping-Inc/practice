import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:practice/constants.dart';
import 'package:practice/pages/home.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  db = await openDatabase(join(await getDatabasesPath(), 'practice.db'),
      onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE pings(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, time INTEGER NOT NULL, text TEXT NOT NULL)',
    );
  }, version: 1);

  runApp(
    ProviderScope(
      child: PingPractice(),
    ),
  );
}

class PingPractice extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Home(),
      ),
    ));
  }
}
