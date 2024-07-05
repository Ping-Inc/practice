import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/last_ping_cell.dart';
import 'package:practice/components/send_ping_icon.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class NewPingPage extends ConsumerStatefulWidget {
  const NewPingPage({super.key});

  @override
  ConsumerState<NewPingPage> createState() => _NewPingPageState();
}

class _NewPingPageState extends ConsumerState<NewPingPage>
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
        bottom: MediaQuery.of(context).viewInsets.bottom + spacingThree,
        left: spacingThree,
        right: spacingThree,
        top: spacingThree,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
              maxLines: 1,
              controller: controller,
              textInputAction: TextInputAction.send,
              onChanged: (value) =>
                  ref.read(currentPingProvider.notifier).set(value),
              onSubmitted: (value) => submitPing(),
              autofocus: true,
              focusNode: focusNode,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                suffixIcon: SendPingIcon(onPressed: submitPing),
                contentPadding: EdgeInsets.symmetric(horizontal: spacingFour),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                        width: thinLine,
                        color: Theme.of(context).colorScheme.surface)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                        width: thinLine,
                        color: Theme.of(context).colorScheme.primary)),
                fillColor: Colors.white,
              )),
          SizedBox(height: spacingThree),
          Row(
            children: [SizedBox(width: 64, child: LastPingCell())],
          )
        ],
      ),
    );
  }
}
