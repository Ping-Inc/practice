import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/constants.dart';
import 'package:practice/design_system/system_text.dart';
import 'package:practice/enums/browse_enum.dart';
import 'package:practice/providers/browse_provider.dart';
import 'package:practice/providers/browse_temp_provider.dart';

class Dial extends ConsumerWidget {
  const Dial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(browseTempProvider) ?? ref.watch(browseProvider);

    return IgnorePointer(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
                offset: Offset(0, 0),
                child: Container(
                    height: pingButtonSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(0, -(pingButtonSize / 2 + 20)),
                          child: Column(children: [
                            SystemText(
                              text: mode == BrowseEnum.focus ? 'Focus' : 'Grid',
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: modeDialHeight,
                              width: 2,
                              color: Colors.white,
                            ),
                          ]),
                        ),
                        Transform.rotate(
                          angle: (mode == BrowseEnum.focus ? -45 : 45) *
                              3.141592653589793 /
                              180, // 30 degrees to radians
                          child: Transform.translate(
                            offset: Offset(0, -(pingButtonSize / 2 + 13)),
                            child: Container(
                              height: modeDialHeight / 2,
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    )))));
  }
}
