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
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color onPrimary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeWhite;
      case ThemeModeEnum.afternoon:
        return themeWhite;
      case ThemeModeEnum.evening:
        return themeBlack;
      case ThemeModeEnum.night:
        return themeBlack;
    }
  }

  static Color secondary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlackSecondary;
      case ThemeModeEnum.afternoon:
        return themeBlackSecondary;
      case ThemeModeEnum.evening:
        return gray;
      case ThemeModeEnum.night:
        return themeWhiteSecondary;
    }
  }

  static Color onSecondary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeWhite;
      case ThemeModeEnum.afternoon:
        return themeWhite;
      case ThemeModeEnum.evening:
        return themeBlack;
      case ThemeModeEnum.night:
        return themeBlack;
    }
  }

  static Color error(ThemeModeEnum themeEnum) {
    return pureRed;
  }

  static Color onError(ThemeModeEnum themeEnum) {
    return themeWhite;
  }

  static Color background(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeYellow;
      case ThemeModeEnum.afternoon:
        return themeWhite;
      case ThemeModeEnum.evening:
        return themeBlue;
      case ThemeModeEnum.night:
        return themeBlack;
    }
  }

  static Color surface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return lightSecondary;
      case ThemeModeEnum.afternoon:
        return lightSecondary;
      case ThemeModeEnum.evening:
        return blueSecondary;
      case ThemeModeEnum.night:
        return darkSecondary;
    }
  }

  static Color onSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color primaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeYellow;
      case ThemeModeEnum.afternoon:
        return themeWhite;
      case ThemeModeEnum.evening:
        return themeBlue;
      case ThemeModeEnum.night:
        return themeBlack;
    }
  }

  static Color onPrimaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color secondaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeYellow;
      case ThemeModeEnum.afternoon:
        return themeWhite;
      case ThemeModeEnum.evening:
        return themeBlue;
      case ThemeModeEnum.night:
        return themeBlack;
    }
  }

  static Color onSecondaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color tertiary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeYellow;
      case ThemeModeEnum.afternoon:
        return themeWhite;
      case ThemeModeEnum.evening:
        return themeBlue;
      case ThemeModeEnum.night:
        return themeBlack;
    }
  }

  static Color onTertiary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color tertiaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeYellow;
      case ThemeModeEnum.afternoon:
        return themeWhite;
      case ThemeModeEnum.evening:
        return themeBlue;
      case ThemeModeEnum.night:
        return themeBlack;
    }
  }

  static Color onTertiaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color errorContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color onErrorContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color surfaceVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeYellow;
      case ThemeModeEnum.afternoon:
        return themeWhite;
      case ThemeModeEnum.evening:
        return themeBlue;
      case ThemeModeEnum.night:
        return themeBlack;
    }
  }

  static Color onSurfaceVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color outline(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color outlineVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color shadow(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color scrim(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color inverseSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color onInverseSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color inversePrimary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }

  static Color surfaceTint(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return themeBlack;
      case ThemeModeEnum.afternoon:
        return themeBlack;
      case ThemeModeEnum.evening:
        return themeWhite;
      case ThemeModeEnum.night:
        return themeWhite;
    }
  }
}
