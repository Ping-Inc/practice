import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/backup_on_provider.dart';
import 'package:practice/providers/backup_path_provider.dart';

class BackupFolderPathButton extends ConsumerWidget {
  const BackupFolderPathButton({Key? key}) : super(key: key);

  Future<void> pickFolder(WidgetRef ref) async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      ref.read(backupPathProvider.notifier).setPath(selectedDirectory);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchOn = ref.watch(backupOnProvider);
    final path = ref.watch(backupPathProvider);

    return Column(children: [
      if (path != null) Text(path.split(" ").last),
      ElevatedButton(
        onPressed: () => switchOn ? pickFolder(ref) : null,
        child: Text(path == null ? 'Select Folder' : 'Change Folder'),
      )
    ]);
  }
}
