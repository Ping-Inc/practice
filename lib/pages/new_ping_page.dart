import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/neighborhood_cell.dart';
import 'package:practice/components/ping_id_cell.dart';
import 'package:practice/components/send_ping_icon.dart';
import 'package:practice/components/time_row.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_drag_handle.dart';
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
        bottom: MediaQuery.of(context).viewInsets.bottom + spacingFour,
        left: spacingFour,
        right: spacingFour,
        top: spacingFour,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TimeRow(),
          SizedBox(height: spacingTwo),
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
                filled: true,
                suffixIcon: SendPingIcon(onPressed: submitPing),
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
                fillColor: Theme.of(context).colorScheme.surface,
              )),
          SizedBox(height: spacingTwo),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [PingIdCell(), NeighborhoodCell()],
          ),
          // SizedBox(height: spacingThree),
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child: ElevatedButton(
          //       child: Text('Capture'),
          //       onPressed: () {
          //         submitPing(context, ref, controller);
          //       },
          //     )),
        ],
      ),
    );
  }
}
