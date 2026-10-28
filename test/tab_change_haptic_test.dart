import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/utils/tab_change_haptic.dart';

/// Three tabs, like the lens row, with a tick counter.
class _Tabs extends StatefulWidget {
  const _Tabs();

  @override
  State<_Tabs> createState() => _TabsState();
}

class _TabsState extends State<_Tabs> with TickerProviderStateMixin {
  late final TabController controller;
  late final TabChangeHaptic haptic;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    haptic = TabChangeHaptic(controller);
  }

  @override
  void dispose() {
    haptic.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          TabBar(
            controller: controller,
            tabs: const [Text('one'), Text('two'), Text('three')],
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                Center(child: Text('page one')),
                Center(child: Text('page two')),
                Center(child: Text('page three')),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

void main() {
  late int ticks;

  setUp(() {
    ticks = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'HapticFeedback.vibrate' &&
          call.arguments == 'HapticFeedbackType.selectionClick') {
        ticks++;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  testWidgets('tapping a lens ticks once, even when skipping over others',
      (tester) async {
    await tester.pumpWidget(const _Tabs());
    await tester.tap(find.text('three'));
    await tester.pumpAndSettle();
    expect(find.text('page three'), findsOneWidget);
    expect(ticks, 1);

    // Tapping the lens you're on does nothing.
    await tester.tap(find.text('three'));
    await tester.pumpAndSettle();
    expect(ticks, 1);
  });

  testWidgets('swiping to the next lens ticks once', (tester) async {
    await tester.pumpWidget(const _Tabs());
    await tester.fling(find.text('page one'), const Offset(-600, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('page two'), findsOneWidget);
    expect(ticks, 1);
  });

  testWidgets('a short swipe that springs back does not tick',
      (tester) async {
    await tester.pumpWidget(const _Tabs());
    await tester.drag(find.text('page one'), const Offset(-150, 0));
    await tester.pumpAndSettle();
    expect(find.text('page one'), findsOneWidget);
    expect(ticks, 0);
  });

  testWidgets('it ticks as the swipe passes halfway, before letting go',
      (tester) async {
    await tester.pumpWidget(const _Tabs());
    final width = tester.getSize(find.byType(TabBarView)).width;
    final gesture =
        await tester.startGesture(tester.getCenter(find.text('page one')));

    await gesture.moveBy(Offset(-width * 0.3, 0));
    await tester.pump();
    expect(ticks, 0);

    await gesture.moveBy(Offset(-width * 0.3, 0));
    await tester.pump();
    expect(ticks, 1);

    await gesture.up();
    await tester.pumpAndSettle();
    expect(find.text('page two'), findsOneWidget);
    expect(ticks, 1);
  });
}
