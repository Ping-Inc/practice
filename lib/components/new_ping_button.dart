import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/latest_ping_provider.dart';
import 'package:practice/providers/pings_count_provider.dart';
import 'package:practice/providers/pings_provider.dart';
import 'package:practice/providers/reply_on_provider.dart';

class NewPingButton extends ConsumerStatefulWidget {
  const NewPingButton(
      {super.key, required this.textEditingController, this.replyPing});

  final TextEditingController textEditingController;
  final PingData? replyPing;

  @override
  ConsumerState<NewPingButton> createState() => _PingEntryState();
}

class _PingEntryState extends ConsumerState<NewPingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int? replyId;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 66),
      vsync: this,
    );
    _animation = Tween<double>(begin: 50, end: 45).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });

    if (widget.replyPing != null) {
      replyId == widget.replyPing!.id;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (replyId == null) {
      if (ref.watch(replyOnProvider)) {
        final latestPing = ref.read(latestPingProvider).value;

        if (latestPing != null) {
          replyId = latestPing.id;
        }
      }
    }

    return SystemTap(
      onTap: ref.watch(currentPingProvider).isEmpty
          ? null
          : () {
              _controller.forward();
              ref
                  .read(pingsProvider.notifier)
                  .addPing(widget.textEditingController.text, replyId);
              ref.read(currentPingProvider.notifier).reset();
              ref.read(replyOnProvider.notifier).reset();
              ref.invalidate(pingsCountProvider);
              Timer(const Duration(milliseconds: 132), () {
                HapticFeedback.selectionClick();
              });

              if (widget.replyPing != null) {
                context.pop();
              }
            },
      child: SizedBox(
        height: pingButtonWidth,
        width: pingButtonWidth,
        child: Stack(
          children: [
            Container(
              height: pingButtonWidth,
              width: pingButtonWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ref.watch(currentPingProvider).isEmpty
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Center(
              child: Container(
                height: _animation.value,
                width: _animation.value,
                decoration: BoxDecoration(
                  color: ref.watch(currentPingProvider).isEmpty
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
