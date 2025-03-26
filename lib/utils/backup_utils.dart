import 'dart:async';
import 'dart:io';
import 'package:icloud_storage_sync/icloud_storage_sync_platform_interface.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/repositories/pings_repository.dart';

class BackupUtils {
  static Future<void> download() async {
    final directory = await getApplicationDocumentsDirectory();

    try {
      final backups = await IcloudStorageSyncPlatform.instance
          .gather(containerId: iCloudContainerId);

      if (backups.isNotEmpty) {
        for (final backup in backups) {
          final destinationFilePath =
              '${directory.path}/backups/${backup.relativePath}';
          final file = File(destinationFilePath);

          if (!await file.exists()) {
            await IcloudStorageSyncPlatform.instance.download(
              containerId: iCloudContainerId,
              relativePath: backup.relativePath,
              destinationFilePath: destinationFilePath,
            );
          }
        }
      }
    } catch (e) {}
  }

  static Future<void> backupPings() async {
    final directory = await getApplicationDocumentsDirectory();

    if (await Permission.storage.request().isGranted) {
      final sha = await prefs.getString(sharedPrefsBackupSha);

      final backupDir = Directory("${directory.path}/backups");

      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      final fileName = 'pings_${sha}.csv';
      final path = "${backupDir.path}/$fileName";
      final File file = File(path);

      final pings = await PingsRepository.fetchAll();
      final pingsList =
          pings.map<PingData>((data) => PingData.fromJson(data)).toList();
      final csvContent = _convertPingsToCSV(pingsList);

      await file.writeAsString(csvContent);

      await IcloudStorageSyncPlatform.instance.upload(
        containerId: iCloudContainerId,
        filePath: path,
        destinationRelativePath: fileName,
      );
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

  static String _convertPingsToCSV(List<PingData> pings) {
    final buffer = StringBuffer();
    buffer.writeln('time,text');
    for (final ping in pings) {
      buffer.writeln('${ping.time.millisecondsSinceEpoch},${ping.text}');
    }
    return buffer.toString();
  }
}
