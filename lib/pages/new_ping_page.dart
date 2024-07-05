import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:practice/components/neighborhood_cell.dart';
import 'package:practice/components/ping_id_cell.dart';
import 'package:practice/components/time_row.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_drag_handle.dart';
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

  void submitPing(
      BuildContext context, WidgetRef ref, TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      HapticFeedback.lightImpact();

      ref.read(pingsProvider.notifier).addPing(controller.text);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + spacingFive,
        left: spacingFive,
        right: spacingFive,
        top: spacingFive,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsets.only(
                  bottom: spacingFive,
                  top: spacingTwo,
                ),
                child: SystemDragHandle()),
          ),
          TimeRow(),
          SizedBox(height: spacingThree),
          TextField(
              minLines: 8,
              maxLines: 8,
              controller: controller,
              textInputAction: TextInputAction.newline,
              onSubmitted: (value) {
                submitPing(context, ref, controller);
              },
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: thinLine,
                        color: Theme.of(context).colorScheme.surface)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: thinLine,
                        color: Theme.of(context).colorScheme.primary)),
                fillColor: Theme.of(context).colorScheme.surface,
              )),
          SizedBox(height: spacingThree),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [PingIdCell(), NeighborhoodCell()],
          ),
          SizedBox(height: spacingThree),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: Text('Capture'),
                onPressed: () {
                  submitPing(context, ref, controller);
                },
              )),
        ],
      ),
    );
  }
}
