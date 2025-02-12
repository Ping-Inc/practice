import 'package:flutter/material.dart';

class TraversalScaffold extends StatelessWidget {
  const TraversalScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(bottom: false, child: child));
  }
}
