import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class NewPingButton extends ConsumerStatefulWidget {
  const NewPingButton({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  ConsumerState<NewPingButton> createState() => _PingEntryState();
}

class _PingEntryState extends ConsumerState<NewPingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 60),
      vsync: this,
    );
    _animation = Tween<double>(begin: 48, end: 44).animate(_controller)
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
      onTap: ref.watch(currentPingProvider).isEmpty
          ? null
          : () {
              _controller.forward();
              ref
                  .read(pingsProvider.notifier)
                  .addPing(widget.textEditingController.text);
              ref.read(currentPingProvider.notifier).reset();
            },
      child: SizedBox(
        height: 58,
        width: 58,
        child: Stack(
          children: [
            Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ref.watch(currentPingProvider).isEmpty
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                  width: 2,
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
