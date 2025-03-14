import 'package:flutter/material.dart';
import 'package:practice/components/header_min.dart';

class PageWithHeader extends StatelessWidget {
  const PageWithHeader({super.key, required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      HeaderMin(title: title),
      Expanded(child: SingleChildScrollView(child: child)),
    ]);
  }
}
