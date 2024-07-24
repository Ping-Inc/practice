import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/new_ping_button.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class PingEntryPage extends ConsumerStatefulWidget {
  const PingEntryPage({super.key});

  @override
  ConsumerState<PingEntryPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<PingEntryPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  Widget build(BuildContext context) {
    ref.listen(pingsProvider, (previous, next) {
      controller.clear();
    });

    return Scaffold(
        body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          TopNav(
              child: SystemButton(
            onTap: () => context.pop(),
            text: "All Ping",
            icon: PhosphorIcons.caret_left,
          )),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingFive),
                child: TextField(
                  textInputAction: TextInputAction.newline,
                  maxLines: 12,
                  focusNode: focusNode,
                  autofocus: true,
                  controller: controller,
                  onChanged: (value) => {
                    ref.read(currentPingProvider.notifier).set(value.trim())
                  },
                  decoration: InputDecoration(
                    // Add this line
                    border: InputBorder.none, // And this one
                  ),
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: FontEnum.garamond.toFontFamily()),
                )),
          ),
          SizedBox(
            height: spacingFive,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NewPingButton(textEditingController: controller),
            ],
          ),
          SizedBox(
            height: spacingFive,
          )
        ]));
  }
}
