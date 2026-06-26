import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_switch.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/pages/settings/settings_scaffold.dart';
import 'package:practice/providers/photos_backup_on_provider.dart';

class SettingsBackupPhotosPage extends ConsumerStatefulWidget {
  const SettingsBackupPhotosPage({super.key});

  @override
  ConsumerState<SettingsBackupPhotosPage> createState() =>
      _SettingsBackupPhotosPageState();
}

class _SettingsBackupPhotosPageState
    extends ConsumerState<SettingsBackupPhotosPage> {
  bool _permissionDenied = false;

  Future<void> _handleToggle(bool value) async {
    if (!value) {
      ref.read(photosBackupOnProvider.notifier).disable();
      setState(() => _permissionDenied = false);
      return;
    }
    final granted = await Gal.requestAccess();
    if (!mounted) return;
    if (granted) {
      ref.read(photosBackupOnProvider.notifier).enable();
      setState(() => _permissionDenied = false);
    } else {
      setState(() => _permissionDenied = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool photosOn = ref.watch(photosBackupOnProvider);

    return SettingsScaffold(
      title: 'Photos Backup',
      subtitle: _permissionDenied
          ? null
          : 'When this setting is enabled, each time you capture a Ping a photo copy will be automatically saved to your Photos. Note: this setting will not affect the state of the cloud and local backup options.',
      subtitleWidget: _permissionDenied ? _buildPermissionDenied(context) : null,
      child: SystemSwitch(
        value: photosOn,
        onChanged: _handleToggle,
      ),
    );
  }

  Widget _buildPermissionDenied(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: TextSizeEnum.fifteen.toFontSize(),
          fontFamily: FontEnum.sfpro.toFontFamily(),
          height: lineHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
        children: [
          const TextSpan(
            text:
                'Ping Practice needs access to your Photos library. Open ',
          ),
          TextSpan(
            text: 'Settings',
            style: const TextStyle(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                HapticFeedback.selectionClick();
                openAppSettings();
              },
          ),
          const TextSpan(text: ' to grant it.'),
        ],
      ),
    );
  }
}
