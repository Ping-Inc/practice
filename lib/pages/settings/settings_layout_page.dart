import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_radio_button.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/extensions/browse_enum_extensions.dart';
import 'package:practice/pages/settings/settings_scaffold.dart';
import 'package:practice/providers/browse_provider.dart';

class SettingsLayoutPage extends ConsumerWidget {
  const SettingsLayoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BrowseEnum browseEnum = ref.watch(browseProvider);

    return SettingsScaffold(
        title: "Default Browse Mode",
        subtitle:
            "Choose how you would like to see Pings presented by default.",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (BrowseEnum mode in BrowseEnum.values)
              SystemRadioButton(
                enabled: true,
                title: mode.title(),
                value: mode,
                groupValue: browseEnum,
                onChanged: (p0) {
                  ref.read(browseProvider.notifier).setMode(p0);
                },
              )
          ],
        ));
  }
}
