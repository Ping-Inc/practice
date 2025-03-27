import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';

class CaptureButton extends ConsumerStatefulWidget {
  const CaptureButton({super.key, required this.onTap, this.disabled = false});

  final VoidCallback onTap;
  final bool disabled;

  @override
  ConsumerState<CaptureButton> createState() => _PingEntryState();
}

class _PingEntryState extends ConsumerState<CaptureButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double pingButtonWidth = 64;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 66),
      vsync: this,
    );
    _animation = Tween<double>(begin: 54, end: 50).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemTap(
      onTap: widget.disabled
          ? null
          : () {
              widget.onTap();
              _controller.forward();

              Timer(const Duration(milliseconds: 132), () {
                HapticFeedback.selectionClick();
              });
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
                  color: widget.disabled
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  width: 4,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Center(
              child: Container(
                height: _animation.value,
                width: _animation.value,
                decoration: BoxDecoration(
                  color: widget.disabled
                      ? Theme.of(context).colorScheme.secondary
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
