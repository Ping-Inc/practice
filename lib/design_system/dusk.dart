import 'package:flutter/material.dart';

/// The fixed grayscale palette for public mode, also used for public pings'
/// cards in private mode.
class Dusk {
  Dusk._();

  static const background = Color(0xFF17181D);
  static const card = Color(0xFF26272E);
  static const text = Color(0xFFDCD5E3);
  static const secondary = Color(0xFF7F7589);
  static const outline = Color(0xFFA79DB3);
}

/// Draws [child] (a ping card) in the dusk colors when [enabled].
///
/// Card, text and #id colors all come from the theme, so swapping the theme's
/// colors here restyles the whole card. The re-ping glow fades between two
/// theme colors, so setting both to the dusk card turns it off.
class PublicCardTheme extends StatelessWidget {
  const PublicCardTheme({super.key, required this.enabled, required this.child});

  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Dusk.text,
          secondary: Dusk.secondary,
          onSurface: Dusk.text,
          surface: Dusk.card,
          secondaryContainer: Dusk.card,
        ),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Dusk.text),
        child: child,
      ),
    );
  }
}
