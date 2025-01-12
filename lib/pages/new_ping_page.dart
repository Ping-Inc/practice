import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/new_ping_button.dart';
import 'package:practice/components/ping_reply_text.dart';
import 'package:practice/components/reply_ping_button.dart';
import 'package:practice/components/top_nav.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/design_system/system_button.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/pings_provider.dart';

class NewPingPage extends ConsumerStatefulWidget {
  const NewPingPage({super.key, this.replyPing});

  final PingData? replyPing;

  @override
  ConsumerState<NewPingPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<NewPingPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.unfocus();
    focusNode.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    ref.listen(pingsProvider, (previous, next) {
      controller.clear();
    });

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        TopNav(
            child: SystemButton(
          onTap: () => context.pop(),
          icon: PhosphorIcons.caret_left,
        )),
        Expanded(
            child: MainSpacingCell(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
              PingReplyText(replyPing: widget.replyPing),
              Expanded(
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
                    hintText: "Listening for pings...",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),

                    // Add this line
                    border: InputBorder.none, // And this one
                  ),
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: FontEnum.garamond.toFontFamily()),
                ),
              ),
              SizedBox(
                height: spacingFive,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  if (widget.replyPing == null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ReplyPingButton(),
                    ),
                  NewPingButton(
                      textEditingController: controller,
                      replyPing: widget.replyPing),
                ],
              ),
              SizedBox(
                height: spacingFive,
              )
            ])))
      ],
    )));
  }
}
