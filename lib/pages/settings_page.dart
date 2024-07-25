import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_divider.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/pages/settings/settings_browse_page.dart';
import 'package:practice/pages/settings/settings_cloud_page.dart';
import 'package:practice/pages/settings/settings_backup_local_page.dart';
import 'package:practice/pages/settings/settings_contrast_page.dart';
import 'package:practice/pages/settings/settings_font_size_page.dart';
import 'package:practice/pages/settings/settings_layout_page.dart';
import 'package:practice/pages/settings/settings_theme_page.dart';

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
                SettingsNavigationCell(
                    text: 'Local',
                    state: 'Off',
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsBackupLocalPage()),
                        )),
                SystemDivider(),
                SettingsNavigationCell(
                    text: 'Cloud',
                    state: 'Off',
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsBackupCloudPage()),
                        )),
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
                SettingsNavigationCell(
                    text: 'Home',
                    state: 'All Pings',
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsLayoutPage()),
                        )),
                SystemDivider(),
                SettingsNavigationCell(
                    text: 'Default Browse Mode',
                    state: 'List',
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsBrowsePage()),
                        )),
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
                SettingsNavigationCell(
                    text: 'Theme',
                    state: 'Time of Day',
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsThemePage()),
                        )),
                SystemDivider(),
                SettingsNavigationCell(
                    text: 'Contrast',
                    state: 'Standard',
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsContrastPage()),
                        )),
                SystemDivider(),
                SettingsNavigationCell(
                    text: 'Font Size',
                    state: 'Standard',
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsFontSizePage()),
                        )),
              ],
            )),
          ],
        ));
  }
}
