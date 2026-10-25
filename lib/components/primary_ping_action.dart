import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/hide_ping_button.dart';
import 'package:practice/components/public_toggle_button.dart';
import 'package:practice/data/ping_data.dart';

/// The first action slot in focus view and Details.
///
/// Hidden → "show". Under 24 hours old → "hide". Otherwise → the "public"
/// toggle, whose icon shows whether the ping is public.
class PrimaryPingAction extends ConsumerWidget {
  const PrimaryPingAction({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return canTogglePublic(ref, ping)
        ? PublicToggleButton(ping: ping)
        : HidePingButton(ping: ping);
  }
}
