import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/ping_background.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/dusk.dart';
import 'package:practice/design_system/system_switch.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/pages/settings/settings_scaffold.dart';
import 'package:practice/providers/derived_pings_providers.dart';

/// Settings › Public.
///
/// The switch and the Passcode row are placeholders for now: the passcode
/// screens come next, then public mode itself.
class SettingsPublicPage extends StatelessWidget {
  const SettingsPublicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: 'Public',
      subtitle: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: spacingSmall),
          _Group(
            row: _SettingsRow(
              label: 'Public mode',
              // Doesn't turn on public mode yet.
              trailing: SystemSwitch(value: false, onChanged: (_) {}),
            ),
            note: 'Only Pings you have made public will appear in Public '
                'mode. Pings can be made public 24 hours after capture.',
          ),
          SizedBox(height: spacingMedium),
          Row(
            children: [
              const _GrayscalePreview(),
              SizedBox(width: spacingSmall),
              Expanded(
                child: SystemText(
                  text: 'In Public mode, Pings will appear in grayscale.',
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: spacingMedium),
          _Group(
            // No arrow and no tap yet: choosing a passcode comes next.
            row: _SettingsRow(
              label: 'Passcode',
              trailing: SystemText(text: 'Not set'),
            ),
            note: 'Once Public mode is enabled, your passcode will be '
                'required to return to Private mode.',
          ),
          SizedBox(height: spacingMedium + MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

/// A single-row settings box with a note underneath.
class _Group extends StatelessWidget {
  const _Group({required this.row, required this.note});

  final Widget row;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PingBackground(
          child: Padding(
            padding: EdgeInsets.only(left: spacingXSmall),
            child: row,
          ),
        ),
        SizedBox(height: spacingSmall),
        SystemText(
          text: note,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.label, required this.trailing});

  final String label;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: spacingFive, vertical: spacingFive / 2),
      child: SizedBox(
        height: tapTarget,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [SystemText(text: label), trailing],
        ),
      ),
    );
  }
}

/// A small dusk card showing how Pings look in public mode: your most
/// recently made public Ping, or the capture screen's placeholder if none.
class _GrayscalePreview extends ConsumerWidget {
  const _GrayscalePreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicPings = ref.watch(publicPingsProvider);
    final latest = publicPings.isEmpty ? null : publicPings.first;

    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: Dusk.background,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 70,
        height: 70,
        padding: const EdgeInsets.fromLTRB(7, 7, 7, 2),
        decoration: BoxDecoration(
          color: Dusk.card,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                latest?.text ?? captureHintDefault,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontFamily: FontEnum.garamond.toFontFamily(),
                  fontSize: 9,
                  height: 1.2,
                  color: Dusk.text,
                ),
              ),
            ),
            if (latest != null)
              Center(
                child: Text(
                  latest.id.toString(),
                  style: const TextStyle(fontSize: 8, color: Dusk.secondary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
