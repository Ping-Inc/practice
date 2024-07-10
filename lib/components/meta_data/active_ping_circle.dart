import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/design_system/system_circle.dart';
import 'package:practice/providers/current_ping_provider.dart';

class ActivePingCircle extends ConsumerWidget {
  const ActivePingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SystemCircle(
        color: ref.watch(currentPingProvider).isEmpty
            ? Colors.grey
            : Theme.of(context).colorScheme.primary);
  }
}
