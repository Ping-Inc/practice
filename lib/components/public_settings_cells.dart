import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/pages/settings/settings_public_page.dart';
import 'package:practice/providers/derived_pings_providers.dart';

/// Settings › Public › "Public mode". Always "Off" here: in public mode,
/// Settings shows its own page.
class PublicModeActivationCell extends StatelessWidget {
  const PublicModeActivationCell({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsNavigationCell(
      text: 'Public mode',
      state: 'Off',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPublicPage()),
      ),
    );
  }
}

/// Settings › Public › "Public Pings": how many Pings are public. Not tappable.
class PublicPingsCountCell extends ConsumerWidget {
  const PublicPingsCountCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(publicPingsProvider).length;

    return Padding(
      padding: EdgeInsets.all(spacingFive),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SystemText(text: 'Public Pings'),
          SystemText(text: count.toString()),
        ],
      ),
    );
  }
}
