import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice/constants.dart';
import 'dart:io';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportPingsButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: EdgeInsets.all(spacingTwo),
          child: SystemButton(
              onTap: () async {
                try {
                  final directory = await getApplicationDocumentsDirectory();

                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          initialDirectory: '${directory.path}',
                          type: FileType.custom,
                          allowedExtensions: ['csv']);

                  if (result != null && result.files.single.path != null) {
                    File file = File(result.files.single.path!);
                    List<String> lines = await file.readAsLines();

                    List<PingData> pings = [];
                    late int textIndex;
                    late int timeIndex;

                    for (var line in lines) {
                      if (line.trim().isEmpty) {
                        continue;
                      }

                      try {
                        var columns = CsvToListConverter().convert(line).first;
                        if (columns.contains('text') &&
                            columns.contains('time')) {
                          textIndex = columns.indexOf('text');
                          timeIndex = columns.indexOf('time');
                        } else {
                          dynamic time = columns[timeIndex];
                          if (time == null) continue;

                          String? text = columns[textIndex];
                          if (text == null) continue;

                          late final int timeInt;

                          if (time is String) {
                            timeInt = int.parse(time);
                          } else {
                            timeInt = time;
                          }

                          pings.add(PingData(
                              resonantCount: 0,
                              viewCount: 0,
                              hidden: false,
                              time:
                                  DateTime.fromMillisecondsSinceEpoch(timeInt),
                              text: text));
                        }
                      } catch (e) {
                        continue;
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
              text: AppLocalizations.of(context)!.import_pings))
    ]);
  }
}
