import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:practice/providers/pings_provider.dart';

class AddPingButton extends ConsumerWidget {
  void submitPing(BuildContext context, WidgetRef ref,
      TextEditingController controller, FocusNode focusNode) {
    HapticFeedback.lightImpact();

    ref.read(pingsProvider.notifier).addPing(controller.text);
    controller.clear();
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    return IconButton(
        onPressed: () {
          HapticFeedback.selectionClick();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("metadata goes here..")]),
                    TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onSubmitted: (value) {
                        submitPing(context, ref, controller, focusNode);
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Enter text',
                      ),
                    ),
                    TextButton(
                      child: Text('done'),
                      onPressed: () {
                        submitPing(context, ref, controller, focusNode);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: Icon(PhosphorIcons.plus));
  }
}
