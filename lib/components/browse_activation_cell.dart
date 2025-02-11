import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/extensions/browse_enum_extensions.dart';
import 'package:practice/pages/settings/settings_layout_page.dart';
import 'package:practice/providers/browse_provider.dart';

class BrowseActivationCell extends ConsumerWidget {
  const BrowseActivationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BrowseEnum browseEnum = ref.watch(browseProvider);

    return SettingsNavigationCell(
      text: 'Default Browse Mode',
      state: browseEnum.title(),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsLayoutPage(),
        ),
      ),
    );
  }
}
