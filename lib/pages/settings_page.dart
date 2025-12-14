import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/browse_activation_cell.dart';
import 'package:practice/components/focus_buttons_settings_cell.dart';
import 'package:practice/components/cached_search_toggle.dart';
import 'package:practice/components/cloud_backup_activation_cell.dart';
import 'package:practice/components/import_pings_button.dart';
import 'package:practice/components/local_backup_activation_cell.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/nav_cell_cluster.dart';
import 'package:practice/components/page_with_header.dart';
import 'package:practice/components/settings_activation_cell.dart';
import 'package:practice/components/saved_lens_row.dart';
import 'package:practice/components/theme_picker.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/providers/feature_flags_provider.dart';
import 'package:practice/providers/local_backup_on_provider.dart';
import 'package:practice/providers/simple_saved_searches_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedSearches = ref.watch(simpleSavedSearchesProvider);
    
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: PageWithHeader(
                title: 'Settings',
                child: MainSpacingCell(
                    bottomPadding: false,
                    child: Column(
                      children: [
                        if (ref.watch(showDevSettingsProvider)) ...[
                          NavCellCluster(text: 'Dev Settings', children: [
                            HideFocusButtonsSettingCell(),
                            CachedSearchToggleCell()
                          ]),
                          SizedBox(
                            height: spacingMedium,
                          ),
                        ],
                        savedSearches.when(
                          data: (searches) => searches.isNotEmpty
                              ? Column(
                                  children: [
                                    NavCellCluster(
                                      text: 'Lenses',
                                      children: [
                                        ...searches.map((lensName) => SavedLensRow(
                                              lensName: lensName,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: spacingMedium),
                                  ],
                                )
                              : SizedBox.shrink(),
                          loading: () => SizedBox.shrink(),
                          error: (_, __) => SizedBox.shrink(),
                        ),
                        NavCellCluster(text: 'Feel', children: [
                          ThemePicker(),
                        ]),
                        SizedBox(
                          height: spacingMedium,
                        ),
                        NavCellCluster(text: 'Backups', children: [
                          LocalBackupActivationCell(),
                          if (ref.watch(localBackupOnProvider))
                            CloudBackupActivationCell(),
                          ImportPingsButton(),
                        ]),
                        SizedBox(
                          height: spacingMedium,
                        ),
                        NavCellCluster(text: 'Layout', children: [
                          BrowseActivationCell(),
                        ]),
                        SizedBox(
                          height: spacingMedium,
                        ),
                        NavCellCluster(text: 'Learn More', children: [
                          SettingsActivationCell(
                            text: 'Ping Practice Method',
                            onTap: () => launchUrl(
                                Uri.parse('https://pingpractice.org/method')),
                          ),
                          SettingsActivationCell(
                            text: 'Transmissions',
                            onTap: () => launchUrl(Uri.parse(
                                'https://pingpractice.org/transmissions')),
                          ),
                          SettingsActivationCell(
                            text: 'Contact',
                            onTap: () => launchUrl(
                                Uri.parse('mailto:everyone@pingpractice.org')),
                          )
                        ]),
                        Padding(
                            padding: EdgeInsets.only(
                                top: spacingXLarge,
                                bottom: spacingMedium +
                                    MediaQuery.of(context).padding.bottom),
                            child: RichText(
                                text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: TextSizeEnum.fifteen.toFontSize(),
                                  fontFamily: FontEnum.sfpro.toFontFamily(),
                                  height: lineHeight,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              children: [
                                TextSpan(
                                  text:
                                      'Ping Practice is a non-profit that continues to be shaped with ',
                                ),
                                TextSpan(
                                  text: 'people',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      HapticFeedback.selectionClick();
                                      final uri = Uri.parse(
                                          'https://pingpractice.org/people');
                                      launchUrl(uri);
                                    },
                                ),
                                TextSpan(
                                  text:
                                      ' who see making meaning from experience as elemental to existence.',
                                ),
                              ],
                            )))
                      ],
                    )))));
  }
}
