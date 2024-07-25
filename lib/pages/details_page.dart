import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/providers/pings_provider.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key, required this.ping});

  final Ping ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Stack(children: [
      Padding(
          padding: EdgeInsets.only(
              left: spacingTwo,
              right: spacingTwo,
              top: spacingFour + MediaQuery.of(context).padding.top),
          child: Row(children: [
            SystemButton(
              onTap: () => Navigator.pop(context),
              text: "All Pings",
              icon: PhosphorIcons.caret_left,
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: SystemText(text: 'Confirm'),
                          content:
                              SystemText(text: 'Do you really want to delete?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: SystemText(text: 'No'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(pingsProvider.notifier)
                                    .deletePing(ping);
                                Navigator.pop(context); // Close the dialog
                                Navigator.pop(context);
                              },
                              child: SystemText(text: 'Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SystemText(text: "Delete"),
                )
              ],
            ))
          ])),
      Center(
          child: Padding(
              padding: EdgeInsets.all(spacingFour),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                        aspectRatio: 1,
                        child: ResizingTextCell(text: ping.text)),
                    SizedBox(height: spacingFour),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: spacingFour,
                      runSpacing: spacingFour,
                      children: <Widget>[
                        TextButton(
                            onPressed: () {},
                            child: SystemText(
                                text: DateFormat('h:mm a').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child: SystemText(
                                text: DateFormat('EEEE').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child: SystemText(
                                text: DateFormat('MMMM').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child: SystemText(
                                text: DateFormat('d').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child: SystemText(
                                text: DateFormat('y').format(ping.time))),
                      ],
                    )
                  ])))
    ]));
  }
}
