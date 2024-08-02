import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';

class BackupUtils {
  static Future<void> backupPings() async {
    final directory = await getApplicationDocumentsDirectory();

    if (await Permission.storage.request().isGranted) {
      final backupDir = Directory("${directory.path}/backups");

      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      final path =
          "${backupDir.path}/${DateFormat('M_d_y').format(DateTime.now())}.csv";
      final File file = File(path);

      final pings = await PingsRepository.fetchAll();
      final pingsList =
          pings.map<PingData>((data) => PingData.fromJson(data)).toList();
      final csvContent = convertPingsToCSV(pingsList);

      await file.writeAsString(csvContent);
    }
  }

  static void openPingsFolder() async {
    final directory = await getApplicationDocumentsDirectory();

    if (await Permission.storage.request().isGranted) {
      final backupDir = Directory("${directory.path}/backups");

      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      // Check if the URI can be launched
      final result = await OpenFile.open(backupDir.path);
      if (result.type != ResultType.done) {
        throw 'Could not open ${backupDir.path}';
      }
    }
  }

  static String convertPingsToCSV(List<PingData> pings) {
    final buffer = StringBuffer();
    buffer.writeln('time,text');
    for (final ping in pings) {
      buffer.writeln('${ping.time.millisecondsSinceEpoch},${ping.text}');
    }
    return buffer.toString();
  }

  void startTimer() {
    stopTimer();

    backupTimer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) async {
        await backupPings();
      },
    );
  }

  void stopTimer() {
    backupTimer?.cancel();
  }
}
