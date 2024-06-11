import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:io';

class ImportPingsButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform
              .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

          if (result != null && result.files.single.path != null) {
            File file = File(result.files.single.path!);
            String contents = await file.readAsString();

            //   final input = file.openRead();

            //   final fields = await input
            //       .transform(utf8.decoder)
            //       .transform(new CsvToListConverter())
            //       .toList();
          }
        },
        child: Text("import pings"),
      )
    ]);
  }
}
