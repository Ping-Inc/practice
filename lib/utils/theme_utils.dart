import 'package:flutter/material.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/theme_mode_enum.dart';

class ThemeUtils {
  ThemeUtils._();

  static ThemeData themeForThemeEnum(
      Brightness brightness, ThemeModeEnum themeEnum) {
    return ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        brightness: brightness,
        scaffoldBackgroundColor: background(themeEnum),
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: primary(themeEnum),
          onPrimary: onPrimary(themeEnum),
          secondary: secondary(themeEnum),
          onSecondary: onSecondary(themeEnum),
          error: error(themeEnum),
          onError: onError(themeEnum),
          surface: surface(themeEnum),
          onSurface: onSurface(themeEnum),
          primaryContainer: primaryContainer(themeEnum),
          onPrimaryContainer: onPrimaryContainer(themeEnum),
          secondaryContainer: secondaryContainer(themeEnum),
          onSecondaryContainer: onSecondaryContainer(themeEnum),
          tertiary: tertiary(themeEnum),
          onTertiary: onTertiary(themeEnum),
          tertiaryContainer: tertiaryContainer(themeEnum),
          onTertiaryContainer: onTertiaryContainer(themeEnum),
          errorContainer: errorContainer(themeEnum),
          onErrorContainer: onErrorContainer(themeEnum),
          surfaceContainerHighest: surfaceVariant(themeEnum),
          onSurfaceVariant: onSurfaceVariant(themeEnum),
          outline: outline(themeEnum),
          outlineVariant: outlineVariant(themeEnum),
          shadow: shadow(themeEnum),
          scrim: scrim(themeEnum),
          inverseSurface: inverseSurface(themeEnum),
          onInverseSurface: onInverseSurface(themeEnum),
          inversePrimary: inversePrimary(themeEnum),
          surfaceTint: surfaceTint(themeEnum),
        ));
  }

  static Color primary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextActiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextActiveBlue;
      case ThemeModeEnum.evening:
        return themeTextActiveBlue;
      case ThemeModeEnum.night:
        return themeTextActiveBlue;
    }
  }

  static Color onPrimary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.afternoon:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.evening:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.night:
        return themeUIBackgroundBlue;
    }
  }

  static Color secondary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextInactiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextInactiveBlue;
      case ThemeModeEnum.evening:
        return themeTextInactiveBlue;
      case ThemeModeEnum.night:
        return themeTextInactiveBlue;
    }
  }

  static Color onSecondary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.afternoon:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.evening:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.night:
        return themeUIBackgroundBlue;
    }
  }

  static Color error(ThemeModeEnum themeEnum) {
    return Color.fromRGBO(255, 0, 0, 1);
  }

  static Color onError(ThemeModeEnum themeEnum) {
    return Colors.white;
  }

  static Color background(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.afternoon:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.evening:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.night:
        return themeUIBackgroundBlue;
    }
  }

  static Color surface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeCardBackgroundBlue;
      case ThemeModeEnum.afternoon:
        return themeCardBackgroundBlue;
      case ThemeModeEnum.evening:
        return themeCardBackgroundBlue;
      case ThemeModeEnum.night:
        return themeCardBackgroundBlue;
    }
  }

  static Color onSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextActiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextActiveBlue;
      case ThemeModeEnum.evening:
        return themeTextActiveBlue;
      case ThemeModeEnum.night:
        return themeTextActiveBlue;
    }
  }

  static Color primaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.afternoon:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.evening:
        return themeUIBackgroundBlue;
      case ThemeModeEnum.night:
        return themeUIBackgroundBlue;
    }
  }

  static Color onPrimaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextActiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextActiveBlue;
      case ThemeModeEnum.evening:
        return themeTextActiveBlue;
      case ThemeModeEnum.night:
        return themeTextActiveBlue;
    }
  }

  static Color secondaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeCardBackgroundBlue;
      case ThemeModeEnum.afternoon:
        return themeCardBackgroundBlue;
      case ThemeModeEnum.evening:
        return themeCardBackgroundBlue;
      case ThemeModeEnum.night:
        return themeCardBackgroundBlue;
    }
  }

  static Color onSecondaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextActiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextActiveBlue;
      case ThemeModeEnum.evening:
        return themeTextActiveBlue;
      case ThemeModeEnum.night:
        return themeTextActiveBlue;
    }
  }

  static Color tertiary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themePingIDInnerBlue;
      case ThemeModeEnum.afternoon:
        return themePingIDInnerBlue;
      case ThemeModeEnum.evening:
        return themePingIDInnerBlue;
      case ThemeModeEnum.night:
        return themePingIDInnerBlue;
    }
  }

  static Color onTertiary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextActiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextActiveBlue;
      case ThemeModeEnum.evening:
        return themeTextActiveBlue;
      case ThemeModeEnum.night:
        return themeTextActiveBlue;
    }
  }

  static Color tertiaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themePingIDOuterBlue;
      case ThemeModeEnum.afternoon:
        return themePingIDOuterBlue;
      case ThemeModeEnum.evening:
        return themePingIDOuterBlue;
      case ThemeModeEnum.night:
        return themePingIDOuterBlue;
    }
  }

  static Color onTertiaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextActiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextActiveBlue;
      case ThemeModeEnum.evening:
        return themeTextActiveBlue;
      case ThemeModeEnum.night:
        return themeTextActiveBlue;
    }
  }

  static Color errorContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return Color.fromRGBO(255, 0, 0, 1);
      case ThemeModeEnum.afternoon:
        return Color.fromRGBO(255, 0, 0, 1);
      case ThemeModeEnum.evening:
        return Color.fromRGBO(255, 0, 0, 1);
      case ThemeModeEnum.night:
        return Color.fromRGBO(255, 0, 0, 1);
    }
  }

  static Color onErrorContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return Colors.white;
      case ThemeModeEnum.afternoon:
        return Colors.white;
      case ThemeModeEnum.evening:
        return Colors.white;
      case ThemeModeEnum.night:
        return Colors.white;
    }
  }

  static Color surfaceVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themePingIDInnerBlue;
      case ThemeModeEnum.afternoon:
        return themePingIDInnerBlue;
      case ThemeModeEnum.evening:
        return themePingIDInnerBlue;
      case ThemeModeEnum.night:
        return themePingIDInnerBlue;
    }
  }

  static Color onSurfaceVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextActiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextActiveBlue;
      case ThemeModeEnum.evening:
        return themeTextActiveBlue;
      case ThemeModeEnum.night:
        return themeTextActiveBlue;
    }
  }

  static Color outline(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themePingIDInnerBlue;
      case ThemeModeEnum.afternoon:
        return themePingIDInnerBlue;
      case ThemeModeEnum.evening:
        return themePingIDInnerBlue;
      case ThemeModeEnum.night:
        return themePingIDInnerBlue;
    }
  }

  static Color outlineVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themePingIDOuterBlue;
      case ThemeModeEnum.afternoon:
        return themePingIDOuterBlue;
      case ThemeModeEnum.evening:
        return themePingIDOuterBlue;
      case ThemeModeEnum.night:
        return themePingIDOuterBlue;
    }
  }

  static Color shadow(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextInactiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextInactiveBlue;
      case ThemeModeEnum.evening:
        return themeTextInactiveBlue;
      case ThemeModeEnum.night:
        return themeTextInactiveBlue;
    }
  }

  static Color scrim(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextInactiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextInactiveBlue;
      case ThemeModeEnum.evening:
        return themeTextInactiveBlue;
      case ThemeModeEnum.night:
        return themeTextInactiveBlue;
    }
  }

  static Color inverseSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextInactiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextInactiveBlue;
      case ThemeModeEnum.evening:
        return themeTextInactiveBlue;
      case ThemeModeEnum.night:
        return themeTextInactiveBlue;
    }
  }

  static Color onInverseSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextInactiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextInactiveBlue;
      case ThemeModeEnum.evening:
        return themeTextInactiveBlue;
      case ThemeModeEnum.night:
        return themeTextInactiveBlue;
    }
  }

  static Color inversePrimary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextInactiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextInactiveBlue;
      case ThemeModeEnum.evening:
        return themeTextInactiveBlue;
      case ThemeModeEnum.night:
        return themeTextInactiveBlue;
    }
  }

  static Color surfaceTint(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeTextInactiveBlue;
      case ThemeModeEnum.afternoon:
        return themeTextInactiveBlue;
      case ThemeModeEnum.evening:
        return themeTextInactiveBlue;
      case ThemeModeEnum.night:
        return themeTextInactiveBlue;
    }
  }
}
