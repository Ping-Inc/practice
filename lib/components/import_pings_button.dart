import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:practice/constants.dart';
import 'dart:io';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportPingsButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextButton(
        onPressed: () async {
          try {
            FilePickerResult? result = await FilePicker.platform
                .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

            if (result != null && result.files.single.path != null) {
              File file = File(result.files.single.path!);
              List<String> lines = await file.readAsLines();

              List<Ping> pings = [];
              late int textIndex;
              late int timeIndex;

              for (var line in lines) {
                var columns = CsvToListConverter().convert(line).first;
                if (columns.contains('text') || columns.contains('text')) {
                  textIndex = columns.indexOf('text');
                  timeIndex = columns.indexOf('time');
                } else {
                  pings.add(Ping(
                      resonantCount: 0,
                      viewCount: 0,
                      hidden: false,
                      time: DateTime.fromMillisecondsSinceEpoch(
                          columns[timeIndex]),
                      text: columns[textIndex]));
                }
              }

              ref.read(pingsProvider.notifier).addAllPings(pings);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  content: SystemText(
                      color: Theme.of(context).colorScheme.onSurface,
                      text: AppLocalizations.of(context)!
                          .pings_imported(pings.length)),
                  duration: Duration(seconds: scaffoldTime)));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                content: SystemText(
                  text: e.toString(),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                duration: Duration(seconds: scaffoldTime)));
          }
        },
        child: SystemText(
          text: AppLocalizations.of(context)!.import_pings,
          align: TextAlign.center,
        ),
      )
    ]);
  }
}
