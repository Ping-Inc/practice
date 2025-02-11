import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/active_development.dart';
import 'package:practice/components/import_pings_button.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/nav_cell_cluster.dart';
import 'package:practice/components/page_with_header.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/components/settings_activation_cell.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: PageWithHeader(
                title: 'Settings',
                child: MainSpacingCell(
                    bottomPadding: false,
                    child: Column(
                      children: [
                        NavCellCluster(text: 'Backups', children: [
                          SettingsNavigationCell(
                            text: 'Local',
                            state: 'Off',
                            onTap: () {},
                          ),
                          SettingsNavigationCell(
                            text: 'Cloud',
                            state: 'Off',
                            onTap: () {},
                          ),
                          ImportPingsButton()
                        ]),
                        SizedBox(
                          height: spacingMedium,
                        ),
                        NavCellCluster(text: 'Layout', children: [
                          SettingsNavigationCell(
                            text: 'Default Browse Mode',
                            state: 'Focus',
                            onTap: () {},
                          ),
                        ]),
                        SizedBox(
                          height: spacingMedium,
                        ),
                        NavCellCluster(text: 'Learn More', children: [
                          SettingsActivationCell(
                            text: 'Ping Practice Method',
                            onTap: () => launchUrl(
                                Uri.parse('https://pingpractice.org/about')),
                          ),
                          SettingsActivationCell(
                            text: 'Transmissions',
                            onTap: () => launchUrl(Uri.parse(
                                'https://pingpractice.org/transmissions')),
                          ),
                          SettingsActivationCell(
                            text: 'Contact',
                            onTap: () => launchUrl(
                                Uri.parse('mailto:contact@pingpractice.org')),
                          )
                        ])
                      ],
                    )))));
  }
}
