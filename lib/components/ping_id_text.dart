import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/meta_data_text.dart';
import 'package:practice/providers/latest_ping_provider.dart';

class PingIdText extends ConsumerWidget {
  const PingIdText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MetaDataText(
        text: "p${switch (ref.watch(latestPingProvider)) {
      AsyncData(value: final latestPing) =>
        latestPing == null ? 1 : latestPing.id.toString(),
      _ => ""
    }}");
  }
}
