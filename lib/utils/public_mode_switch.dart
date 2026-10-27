import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/pages/passcode_page.dart';
import 'package:practice/providers/app_mode_provider.dart';
import 'package:practice/providers/browse_provider.dart';
import 'package:practice/providers/passcode_provider.dart';
import 'package:practice/providers/search_string_provider.dart';

/// Turns on public mode. The first time, choosing a passcode comes first;
/// cancelling it leaves the app in private mode. Ends on the pings view, in
/// grid.
Future<void> enterPublicMode(BuildContext context, WidgetRef ref) async {
  await ref.read(passcodeProvider.notifier).ready;
  if (!context.mounted) return;

  if (!ref.read(passcodeProvider)) {
    final passcodeSet = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
          builder: (context) => const PasscodePage(flow: PasscodeFlow.set)),
    );
    if (passcodeSet != true || !context.mounted) return;
  }

  ref.read(browseProvider.notifier).setMode(BrowseEnum.grid);
  // A private search term mustn't carry over into public mode.
  ref.read(searchStringProvider.notifier).setSearch('');
  await ref.read(appModeProvider.notifier).enterPublic();
  if (context.mounted) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

/// Asks for the passcode (or Face ID), then returns to private mode and the
/// pings view. Cancelling stays in public mode.
Future<void> returnToPrivateMode(BuildContext context, WidgetRef ref) async {
  final unlocked = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
        builder: (context) => const PasscodePage(flow: PasscodeFlow.unlock)),
  );
  if (unlocked != true || !context.mounted) return;

  ref.read(searchStringProvider.notifier).setSearch('');
  await ref.read(appModeProvider.notifier).returnToPrivate();
  if (context.mounted) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
