import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/components/focus_grid_zoom.dart';
import 'package:practice/enums/browse_enum.dart';

final _mode = StateProvider<BrowseEnum>((ref) => BrowseEnum.focus);

Widget app({bool reduceMotion = false}) => ProviderScope(
      overrides: [
        currentBrowseModeProvider.overrideWith((ref) => ref.watch(_mode)),
      ],
      child: MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: reduceMotion),
          child: FocusGridZoom(
            focus: (_) => const Text('FOCUS'),
            grid: (_) => const Text('GRID'),
          ),
        ),
      ),
    );

double scaleOf(WidgetTester tester, String text) {
  final transform = tester.widget<Transform>(find
      .ancestor(of: find.text(text), matching: find.byType(Transform))
      .first);
  // The horizontal scale (the depth axis always stays at 1).
  return transform.transform.storage[0];
}

void main() {
  testWidgets('zooms from focus to grid, then shows only the grid',
      (tester) async {
    await tester.pumpWidget(app());
    expect(find.text('FOCUS'), findsOneWidget);
    expect(find.text('GRID'), findsNothing);

    final container =
        ProviderScope.containerOf(tester.element(find.text('FOCUS')));
    container.read(_mode.notifier).state = BrowseEnum.grid;

    // Mid-zoom: both views, focus shrinking, grid coming in from larger.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.text('FOCUS'), findsOneWidget);
    expect(find.text('GRID'), findsOneWidget);
    expect(scaleOf(tester, 'FOCUS'), lessThan(1));
    expect(scaleOf(tester, 'GRID'), greaterThan(1));

    // Done: only the grid, at full size.
    await tester.pumpAndSettle();
    expect(find.text('FOCUS'), findsNothing);
    expect(find.text('GRID'), findsOneWidget);
    expect(scaleOf(tester, 'GRID'), closeTo(1, 0.001));
  });

  testWidgets('with Reduce Motion it fades without changing size',
      (tester) async {
    await tester.pumpWidget(app(reduceMotion: true));
    final container =
        ProviderScope.containerOf(tester.element(find.text('FOCUS')));
    container.read(_mode.notifier).state = BrowseEnum.grid;

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('GRID'), findsOneWidget);
    // Mid-fade, the incoming grid is already at full size (no zoom).
    expect(scaleOf(tester, 'GRID'), closeTo(1, 0.001));

    await tester.pumpAndSettle();
    expect(find.text('FOCUS'), findsNothing);
  });
}
