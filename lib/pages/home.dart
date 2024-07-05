import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/current_ping_cell.dart';
import 'package:practice/pages/new_ping_page.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(child: SingleChildScrollView(child: CurrentPingCell())),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: NewPingPage()),
        ]);
  }
}
