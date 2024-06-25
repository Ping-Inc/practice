import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/utils/sheets.dart';

class AddPingButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.surface,
        onPressed: () {
          HapticFeedback.selectionClick();
          Sheets.showAddPing(context, ref);
        },
        child: Icon(PhosphorIcons.plus));
  }
}
