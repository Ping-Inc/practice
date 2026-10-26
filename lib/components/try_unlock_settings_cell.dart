import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_activation_cell.dart';
import 'package:practice/pages/passcode_page.dart';
import 'package:practice/providers/passcode_provider.dart';

/// TEMPORARY (remove in slice 5): opens the Unlock screen so the passcode and
/// Face ID can be tried before public mode exists. On success it just returns
/// to Settings.
class TryUnlockSettingCell extends ConsumerWidget {
  const TryUnlockSettingCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsActivationCell(
      text: 'Try the unlock screen',
      onTap: () {
        if (!ref.read(passcodeProvider)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              content: Text(
                'Set a passcode in Settings › Public first.',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const PasscodePage(flow: PasscodeFlow.unlock),
          ),
        );
      },
    );
  }
}
