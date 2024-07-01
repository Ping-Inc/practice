import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/add_ping_button.dart';
import 'package:practice/components/resizing_text_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping.dart';

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
                            child:
                                Text(DateFormat('MMMM').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child:
                                Text(DateFormat('d').format(ping.time))),
                        TextButton(
                            onPressed: () {},
                            child:
                                Text(DateFormat('y').format(ping.time))),
                      ],
                    )
                  ])))
    ]));
  }
}
