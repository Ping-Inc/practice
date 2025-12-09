import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice/components/settings_activation_cell.dart';
import 'package:practice/constants.dart';
import 'package:universal_io/io.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:practice/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

class ImportPingsButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsActivationCell(
        onTap: () async {
          try {
            // Directory is not needed for web file picking
            String? initialDirectory;
            if (!kIsWeb) {
               final directory = await getApplicationDocumentsDirectory();
               initialDirectory = directory.path;
            }

            FilePickerResult? result = await FilePicker.platform.pickFiles(
                initialDirectory: initialDirectory,
                type: FileType.custom,
                allowedExtensions: ['csv']);

            if (result != null) {
              List<String> lines = [];
              
              if (kIsWeb) {
                final bytes = result.files.single.bytes;
                if (bytes != null) {
                  final content = utf8.decode(bytes);
                  lines = LineSplitter.split(content).toList();
                }
              } else if (result.files.single.path != null) {
                File file = File(result.files.single.path!);
                lines = await file.readAsLines();
              }

              if (lines.isNotEmpty) {

              List<PingData> pings = [];
              late int textIndex;
              late int timeIndex;

              for (var line in lines) {
                if (line.trim().isEmpty) {
                  continue;
                }

                try {
                  var columns = CsvToListConverter().convert(line).first;
                  if (columns.contains('text') && columns.contains('time')) {
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
                        resonantTime: null,
                        hidden: false,
                        time: DateTime.fromMillisecondsSinceEpoch(timeInt),
                        text: text));
                  }
                } catch (e) {
                  continue;
                }
              }

              ref.read(pingsMapProvider.notifier).addAllPings(pings);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  content: SystemText(
                      color: Theme.of(context).colorScheme.onSurface,
                      text: AppLocalizations.of(context)!
                          .pings_imported(pings.length)),
                  duration: Duration(seconds: scaffoldTime)));
            }
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
        text: AppLocalizations.of(context)!.import_pings);
  }
}
