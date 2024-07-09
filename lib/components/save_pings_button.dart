import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/backup_on_provider.dart';
import 'package:practice/providers/backup_path_provider.dart';

class SavePingsButton extends ConsumerWidget {
  const SavePingsButton({Key? key}) : super(key: key);

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
      if (path != null) SystemText(text: path.split(" ").last),
      ElevatedButton(
        onPressed: () => switchOn ? pickFolder(ref) : null,
        child:
            SystemText(text: path == null ? 'Select Folder' : 'Change Folder'),
      )
    ]);
  }
}
