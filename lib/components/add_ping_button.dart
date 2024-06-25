import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/providers/hide_home_screen_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class AddPingButton extends ConsumerWidget {
  void submitPing(BuildContext context, WidgetRef ref,
      TextEditingController controller, FocusNode focusNode) {
    if (controller.text.isNotEmpty) {
      HapticFeedback.lightImpact();

      ref.read(pingsProvider.notifier).addPing(controller.text);
      controller.clear();
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    return FloatingActionButton(
        onPressed: () {
          HapticFeedback.selectionClick();
          ref.read(hideHomeScreenProviderProvider.notifier).toggle();

          showModalBottomSheet(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(spacingFive),
                topRight: Radius.circular(spacingFive),
              ),
            ),
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                          height: tapTarget,
                          width: tapTarget,
                          child: Center(
                              child: Icon(
                            PhosphorIcons.x_thin,
                            color: Theme.of(context).colorScheme.primary,
                            size: smallX,
                          ))),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: spacingFour,
                    right: spacingFour,
                    top: spacingFour,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "metadata goes here..",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            )
                          ]),
                      TextField(
                        minLines: 1,
                        maxLines: 6,
                        controller: controller,
                        focusNode: focusNode,
                        textInputAction: TextInputAction.newline,
                        onSubmitted: (value) {
                          submitPing(context, ref, controller, focusNode);
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'ping',
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
                )
              ]);
            },
          ).then((value) {
            ref.read(hideHomeScreenProviderProvider.notifier).toggle();
          });
          ;
        },
        child: Icon(PhosphorIcons.plus));
  }
}
