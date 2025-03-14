// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/pages/settings/settings_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBackupCloudPage extends ConsumerWidget {
  const SettingsBackupCloudPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsScaffold(
        title: "Cloud Backup",
        subtitle:
            "This app automatically tries to save Local Backups to your iCloud account. \n\nUnfortunately Apple provides no way for you to turn the setting on and off from within this app, so it is up to you to make sure the cloud settings on your device reflect your interests.\n\nTo do that, tap the button below to go to your Settings app, and then follow:\n\nYour Name/ Apple Account →\niCloud →\nSaved to iCloud (See All) →\nScroll down and verify 'ping practice' is toggled on",
        child: ElevatedButton(
          onPressed: () {
            launch('App-Prefs:root=General');
          },
          child: SystemText(text: 'Settings'),
        ));
  }
}
