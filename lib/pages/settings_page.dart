import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/backups_on_switch.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_switch.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              HapticFeedback.selectionClick();
                              Navigator.pop(context);
                            },
                            child: Text("Back")),
                      ],
                    )),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: spacingTwo,
                          right: spacingTwo,
                          top: spacingFour),
                      child: Column(
                        children: [
                          Text("Backup", style: TextStyle(fontSize: 24)),
                          BackupsOnSwitch()
                        ],
                      )),
                ))
              ],
            )));
  }
}
