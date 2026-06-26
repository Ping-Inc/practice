import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/settings_navigation_cell.dart';
import 'package:practice/pages/settings/settings_backup_photos_page.dart';
import 'package:practice/providers/photos_backup_on_provider.dart';

class PhotosBackupActivationCell extends ConsumerWidget {
  const PhotosBackupActivationCell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool photosOn = ref.watch(photosBackupOnProvider);

    return SettingsNavigationCell(
      text: 'Photos',
      state: photosOn ? 'On' : 'Off',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsBackupPhotosPage(),
        ),
      ),
    );
  }
}
