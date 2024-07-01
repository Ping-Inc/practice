import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';
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
            TextButton(
                onPressed: () {
                  HapticFeedback.selectionClick();
                  Navigator.pop(context);
                },
                child: Text("Back")),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      Navigator.pop(context);
                    },
                    child: Text("Edit")),
                TextButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm'),
                          content: Text('Do you really want to delete?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(pingsProvider.notifier)
                                    .deletePing(ping);
                                Navigator.pop(context); // Close the dialog
                                Navigator.pop(context);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Delete"),
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
                            child:
                                Text(DateFormat('h:mm a').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child: Text(DateFormat('EEEE').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child: Text(DateFormat('MMMM').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child: Text(DateFormat('d').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child: Text(DateFormat('y').format(ping.time))),
                      ],
                    )
                  ])))
    ]));
  }
}
