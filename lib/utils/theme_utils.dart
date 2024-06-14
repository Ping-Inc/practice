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
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color onPrimary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return white3;
      case ThemeModeEnum.afternoon:
        return white3;
      case ThemeModeEnum.evening:
        return black3;
      case ThemeModeEnum.night:
        return black3;
    }
  }

  static Color secondary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return yellow1;
      case ThemeModeEnum.afternoon:
        return white1;
      case ThemeModeEnum.evening:
        return blue1;
      case ThemeModeEnum.night:
        return black1;
    }
  }

  static Color onSecondary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return white3;
      case ThemeModeEnum.afternoon:
        return white3;
      case ThemeModeEnum.evening:
        return black3;
      case ThemeModeEnum.night:
        return black3;
    }
  }

  static Color error(ThemeModeEnum themeEnum) {
    return pureRed;
  }

  static Color onError(ThemeModeEnum themeEnum) {
    return Colors.white;
  }

  static Color background(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return yellow3;
      case ThemeModeEnum.afternoon:
        return white3;
      case ThemeModeEnum.evening:
        return blue3;
      case ThemeModeEnum.night:
        return black3;
    }
  }

  static Color surface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return yellow2;
      case ThemeModeEnum.afternoon:
        return white2;
      case ThemeModeEnum.evening:
        return blue2;
      case ThemeModeEnum.night:
        return black2;
    }
  }

  static Color onSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color primaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return yellow3;
      case ThemeModeEnum.afternoon:
        return white3;
      case ThemeModeEnum.evening:
        return blue3;
      case ThemeModeEnum.night:
        return black3;
    }
  }

  static Color onPrimaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color secondaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return yellow3;
      case ThemeModeEnum.afternoon:
        return white3;
      case ThemeModeEnum.evening:
        return blue3;
      case ThemeModeEnum.night:
        return black3;
    }
  }

  static Color onSecondaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color tertiary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return yellow3;
      case ThemeModeEnum.afternoon:
        return white3;
      case ThemeModeEnum.evening:
        return blue3;
      case ThemeModeEnum.night:
        return black3;
    }
  }

  static Color onTertiary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color tertiaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return yellow3;
      case ThemeModeEnum.afternoon:
        return white3;
      case ThemeModeEnum.evening:
        return blue3;
      case ThemeModeEnum.night:
        return black3;
    }
  }

  static Color onTertiaryContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color errorContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color onErrorContainer(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color surfaceVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return yellow3;
      case ThemeModeEnum.afternoon:
        return white3;
      case ThemeModeEnum.evening:
        return blue3;
      case ThemeModeEnum.night:
        return black3;
    }
  }

  static Color onSurfaceVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color outline(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color outlineVariant(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color shadow(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color scrim(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color inverseSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color onInverseSurface(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color inversePrimary(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }

  static Color surfaceTint(ThemeModeEnum themeEnum) {
    switch (themeEnum) {
      case ThemeModeEnum.morning:
        return black3;
      case ThemeModeEnum.afternoon:
        return black3;
      case ThemeModeEnum.evening:
        return white3;
      case ThemeModeEnum.night:
        return white3;
    }
  }
}
