import 'dart:async';
import 'dart:io';
import 'package:practice/constants.dart';

class BackupUtils {
  static Future<void> backupPings() async {
    final path = prefs.getString(sharedPrefsBackupPathKey);

    if (path != null) {
      final fullPath = "${path}/pings_${DateTime.now().toIso8601String()}.csv";
      final File file = File(fullPath);
      await file.writeAsString("test");
    }
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
