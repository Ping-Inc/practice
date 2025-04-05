import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/components/flash_animation.dart';
import 'package:practice/components/header_min.dart';
import 'package:practice/components/main_spacing_cell.dart';
import 'package:practice/components/new_ping_button.dart';
import 'package:practice/components/ping_reply_text.dart';
import 'package:practice/components/reply_ping_button.dart';
import 'package:practice/constants.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/providers/current_ping_provider.dart';
import 'package:practice/providers/pings_map_provider.dart';

class NewPingPage extends ConsumerStatefulWidget {
  const NewPingPage({super.key, this.replyPing});

  final PingData? replyPing;

  @override
  ConsumerState<NewPingPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<NewPingPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool isTransitioning = false;
  final GlobalKey<FlashAnimationState> _flashKey =
      GlobalKey<FlashAnimationState>();

  @override
  void dispose() {
    focusNode.unfocus();
    focusNode.dispose();

    super.dispose();
  }

  void _onFlashComplete() {
    setState(() {
      isTransitioning = false;
    });
  }

  Widget build(BuildContext context) {
    ref.listen(pingsMapProvider, (previous, next) {
      setState(() {
        isTransitioning = true;
      });
      controller.clear();
    });

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: FlashAnimation(
            key: _flashKey,
            isTransitioning: isTransitioning,
            onComplete: _onFlashComplete,
            child: SafeArea(
                child: Column(
              children: [
                HeaderMin(subtitle: "all pings"),
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
                            ref
                                .read(currentPingProvider.notifier)
                                .set(value.trim())
                          },
                          decoration: InputDecoration(
                            hintText: "Listening for pings...",
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                            border: InputBorder.none,
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
            ))));
  }
}
