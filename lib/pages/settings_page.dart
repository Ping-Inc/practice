import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/backup_on_switch.dart';
import 'package:practice/components/cloud_sync_cell.dart';
import 'package:practice/components/local_backup_cell.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(spacingFour),
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SystemText(
              text: 'Settings',
              size: TextSizeEnum.thirtySix,
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: spacingSix, top: spacingFive, bottom: spacingFour),
                child: SystemText(
                  text: 'BACKUPS',
                  size: TextSizeEnum.fifteen,
                )),
            PingBackground(
                child: Column(
              children: [
                SettingsNavigationCell(text: 'Local', state: 'Off'),
                SystemDivider(),
                SettingsNavigationCell(text: 'Cloud', state: 'Off'),
              ],
            )),
            SizedBox(height: spacingFour),
            Padding(
                padding: EdgeInsets.only(
                    left: spacingSix, top: spacingFive, bottom: spacingFour),
                child: SystemText(
                  text: 'LAYOUT',
                  size: TextSizeEnum.fifteen,
                )),
            PingBackground(
                child: Column(
              children: [
                SettingsNavigationCell(text: 'Home', state: 'All Pings'),
                SystemDivider(),
                SettingsNavigationCell(
                    text: 'Default Browse Mode', state: 'List'),
              ],
            )),
            SizedBox(height: spacingFour),
            Padding(
                padding: EdgeInsets.only(
                    left: spacingSix, top: spacingFive, bottom: spacingFour),
                child: SystemText(
                  text: 'CUSTOMIZATION',
                  size: TextSizeEnum.fifteen,
                )),
            PingBackground(
                child: Column(
              children: [
                SettingsNavigationCell(text: 'Theme', state: 'Time of Day'),
                SystemDivider(),
                SettingsNavigationCell(text: 'Contrast', state: 'Standard'),
                SystemDivider(),
                SettingsNavigationCell(text: 'Font Size', state: 'Standard'),
              ],
            )),
          ],
        ));
  }
}
