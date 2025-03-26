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
            "Ping Practice automatically tries to save Local Backups of the Pings you capture to your iCloud account.\n\nTo adjust this setting, you need to visit your iPhone's Settings app and follow these steps:\n\n1. Tap your name / Apple account\n2. Tap \"iCloud\"\n3. Scroll to \"Saved to iCloud\"\n4. Tap \"See All\"\n5. Scroll down and verify \"ping practice\" is toggled on",
        child: ElevatedButton(
          onPressed: () {
            launch('App-Prefs:root=General');
          },
          child: SystemText(text: 'Settings'),
        ));
  }
}
