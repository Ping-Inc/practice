import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_switch.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/pages/settings/settings_scaffold.dart';
import 'package:practice/providers/local_backup_on_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBackupLocalPage extends ConsumerWidget {
  const SettingsBackupLocalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool localOn = ref.watch(localBackupOnProvider);

    return SettingsScaffold(
        title: "Local Backup",
        subtitle: localOn
            ? null
            : 'The Pings you capture from this point forward will not be backed up locally or to the cloud. These Ping will be lost if/when you choose to uninstall the Ping Practice app.',
        subtitleWidget: localOn
            ? RichText(
                text: TextSpan(
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: TextSizeEnum.fifteen.toFontSize(),
                    fontFamily: FontEnum.sfpro.toFontFamily(),
                    height: lineHeight,
                    color: themeTextActiveBlue),
                children: [
                  TextSpan(
                    text:
                        'Pings you capture are automatically backed up to a CSV file stored in the ',
                  ),
                  TextSpan(
                    text: 'Files',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        HapticFeedback.selectionClick();
                        final uri = Uri.parse('shareddocuments://');
                        launchUrl(uri);
                      },
                  ),
                  TextSpan(
                    text:
                        ' app on this device. To save a copy to your iCloud account, visit the "Cloud" section within Settings.',
                  ),
                ],
              ))
            : null,
        child: SystemSwitch(
            value: localOn,
            onChanged: (val) =>
                ref.read(localBackupOnProvider.notifier).toggle()));
  }
}
