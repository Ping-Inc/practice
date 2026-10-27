import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_action_image.dart';
import 'package:practice/providers/feature_flags_provider.dart';
import 'package:practice/providers/ping_provider.dart';

/// Whether [ping] can show the "public" toggle right now: Public mode is
/// switched on, the ping isn't hidden, and it's at least 24 hours old.
bool canTogglePublic(WidgetRef ref, PingData ping) {
  final reactivePing = ref.watch(pingProvider(ping));
  return ref.watch(publicModeEnabledProvider) &&
      !reactivePing.hidden &&
      reactivePing.canBePublic(DateTime.now());
}

/// The "public" toggle. The label never changes; the icon shows whether the
/// ping is public (filled ripple) or private (ripple outline).
class PublicToggleButton extends ConsumerWidget {
  const PublicToggleButton({super.key, required this.ping});

  final PingData ping;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPublic =
        ref.watch(pingProvider(ping).select((p) => p.isPublic));

    return Semantics(
      toggled: isPublic,
      child: SystemActionImage(
        onTap: () {
          final notifier = ref.read(pingProvider(ping).notifier);
          isPublic ? notifier.makePrivate() : notifier.makePublic();
        },
        height: 18,
        imagePath: isPublic
            ? 'images/icons/public_on.svg'
            : 'images/icons/public_off.svg',
        text: 'public',
      ),
    );
  }
}
