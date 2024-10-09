import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/import_pings_button.dart';
import 'package:practice/components/navigation_cell.dart';
import 'package:practice/components/navigation_cell_cluster.dart';
import 'package:practice/components/page_with_header.dart';
import 'package:practice/pages/settings/settings_browse_page.dart';
import 'package:practice/pages/settings/settings_cloud_page.dart';
import 'package:practice/pages/settings/settings_backup_local_page.dart';
import 'package:practice/pages/settings/settings_contrast_page.dart';
import 'package:practice/pages/settings/settings_font_size_page.dart';
import 'package:practice/pages/settings/settings_layout_page.dart';
import 'package:practice/pages/settings/settings_theme_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: PageWithHeader(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
          NavigationCellCluster(title: "Backups", children: [
            ImportPingsButton(),
            NavigationCell(
                label: 'Local',
                value: 'Off',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsBackupLocalPage()),
                    )),
            NavigationCell(
                label: 'Cloud',
                value: 'Off',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsBackupCloudPage()),
                    )),
          ]),
          NavigationCellCluster(title: "Layout", children: [
            NavigationCell(
                label: 'Home',
                value: 'All Pings',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsLayoutPage()),
                    )),
            NavigationCell(
                label: 'Default Browse Mode',
                value: 'List',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsBrowsePage()),
                    )),
          ]),
          NavigationCellCluster(title: "Customization", children: [
            NavigationCell(
                label: 'Theme',
                value: 'Time of Day',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsThemePage()),
                    )),
            NavigationCell(
                label: 'Contrast',
                value: 'Standard',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsContrastPage()),
                    )),
            NavigationCell(
                label: 'Font Size',
                value: 'Standard',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsFontSizePage()),
                    )),
          ])
        ])))));
  }
}
