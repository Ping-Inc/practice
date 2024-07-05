import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_list.dart';
import 'package:practice/constants.dart';

class PingsPage extends ConsumerWidget {
  const PingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: spacingTwo, right: spacingTwo, top: spacingFour),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              HapticFeedback.selectionClick();
                              Navigator.pop(context);
                            },
                            child: Text("Back")),
                      ],
                    )),
                Expanded(child: PingList())
              ],
            )));
  }
}
