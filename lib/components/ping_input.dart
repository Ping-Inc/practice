import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/system_tap.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class PingInput extends ConsumerStatefulWidget {
  const PingInput({super.key});

  @override
  ConsumerState<PingInput> createState() => _NewPingPageState();
}

class _NewPingPageState extends ConsumerState<PingInput>
    with WidgetsBindingObserver {
  final now = DateTime.now();
  final controller = TextEditingController();
  final focusNode = FocusNode();

  void submitPing() {
    if (controller.text.isNotEmpty) {
      HapticFeedback.lightImpact();

      ref.read(pingsProvider.notifier).addPing(controller.text);
      ref.read(currentPingProvider.notifier).reset();
      controller.clear();
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + spacingFour,
          left: spacingFour,
          right: spacingFour,
          top: spacingFour,
        ),
        child: SizedBox(
          height: 34,
          child: Stack(
            children: [
              TextField(
                  maxLines: 1,
                  controller: controller,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) =>
                      {ref.read(currentPingProvider.notifier).set(value)},
                  onSubmitted: (value) => submitPing(),
                  autofocus: true,
                  focusNode: focusNode,
                  style: TextStyle(color: Colors.black),
                  cursorColor:
                      Colors.black, // Set your desired cursor color here
                  decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: spacingFour, vertical: spacingThree),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                              width: thinLine,
                              color: Theme.of(context).colorScheme.surface)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide:
                              BorderSide(width: thinLine, color: gray2)),
                      fillColor: Colors.white)),
              if (ref.watch(currentPingProvider).isNotEmpty)
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.only(right: spacingFour),
                        child: SystemTap(
                            child: Container(
                                height: 23,
                                width: 23,
                                decoration: BoxDecoration(
                                    color: blue, shape: BoxShape.circle),
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Colors.white,
                                  size: 16,
                                )),
                            onTap: submitPing))),
            ],
          ),
        ));
  }
}
