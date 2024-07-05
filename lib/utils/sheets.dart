import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/pages/new_ping_page.dart';
import 'package:practice/providers/hide_home_screen_provider.dart';

class Sheets {
  static void showAddPing(BuildContext context, WidgetRef ref) {
    ref.read(hideHomeScreenProviderProvider.notifier).toggle();
    final focusNode = FocusNode();

    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(spacingFive),
          topRight: Radius.circular(spacingFive),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NewPingPage();
      },
    ).then((value) {
      ref.read(hideHomeScreenProviderProvider.notifier).toggle();
    });
  }
}
