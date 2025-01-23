import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/design_system/system_button.dart';

class TraversalShell extends StatelessWidget {
  const TraversalShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                TopNav(
                  child: SystemButton(
                      onTap: () => Navigator.pop(context),
                      icon: PhosphorIcons.caret_left),
                ),
                Expanded(child: child)
              ],
            )));
  }
}
