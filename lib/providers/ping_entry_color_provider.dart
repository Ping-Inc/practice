import 'package:flutter/material.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ping_entry_color_provider.g.dart';

@riverpod
Color pingEntryColor(PingEntryColorRef ref) {
  final currentPing = ref.watch(currentPingProvider);

  return currentPing.isEmpty ? Colors.grey : Colors.black;
}
