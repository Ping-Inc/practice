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
            // Not const, like the real views (which take a list of pings).
            focus: (_) => _Counted('FOCUS'),
            grid: (_) => _Counted('GRID'),
          ),
        ),
      ),
    );

/// How many times each view has been built.
final builds = <String, int>{};

class _Counted extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _Counted(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    builds[label] = (builds[label] ?? 0) + 1;
    return Text(label);
  }
}

double opacityOf(WidgetTester tester, String text) => tester
    .widget<Opacity>(find
        .ancestor(of: find.text(text), matching: find.byType(Opacity))
        .first)
    .opacity;

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

    // The grid is put in place first, still invisible, and the zoom starts
    // once that frame is drawn.
    await tester.pump();
    expect(find.text('GRID'), findsOneWidget);
    expect(opacityOf(tester, 'GRID'), 0);
    expect(scaleOf(tester, 'FOCUS'), 1);

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
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('GRID'), findsOneWidget);
    expect(opacityOf(tester, 'GRID'), inExclusiveRange(0, 1));
    // Mid-fade, the incoming grid is already at full size (no zoom).
    expect(scaleOf(tester, 'GRID'), closeTo(1, 0.001));

    await tester.pumpAndSettle();
    expect(find.text('FOCUS'), findsNothing);
  });

  testWidgets('each view is built once per switch, not on every frame',
      (tester) async {
    builds.clear();
    await tester.pumpWidget(app());
    expect(builds, {'FOCUS': 1});

    final container =
        ProviderScope.containerOf(tester.element(find.text('FOCUS')));
    container.read(_mode.notifier).state = BrowseEnum.grid;
    await tester.pumpAndSettle();

    // The grid was built once; the focus view, on its way out, not again.
    expect(builds, {'FOCUS': 1, 'GRID': 1});

    container.read(_mode.notifier).state = BrowseEnum.focus;
    await tester.pumpAndSettle();
    expect(builds, {'FOCUS': 2, 'GRID': 1});
  });

  testWidgets('turning back before the zoom starts goes back cleanly',
      (tester) async {
    await tester.pumpWidget(app());
    final container =
        ProviderScope.containerOf(tester.element(find.text('FOCUS')));

    // To grid and straight back, within the same frame.
    container.read(_mode.notifier).state = BrowseEnum.grid;
    container.read(_mode.notifier).state = BrowseEnum.focus;
    await tester.pumpAndSettle();
    expect(find.text('FOCUS'), findsOneWidget);
    expect(find.text('GRID'), findsNothing);
    expect(scaleOf(tester, 'FOCUS'), closeTo(1, 0.001));
  });
}
