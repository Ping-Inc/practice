import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color get background {
    final hslColor = HSLColor.fromColor(this);
    final darkenedColor =
        hslColor.withLightness((hslColor.lightness * 0.68).clamp(0.0, 1.0));
    return darkenedColor.toColor();
  }

  Color get ping {
    return this;
  }

  Color get pingResonant {
    final hslColor = HSLColor.fromColor(this);
    // Original pingResonant was brighter and more saturated than base color
    final adjustedColor = hslColor
        .withLightness((hslColor.lightness * 1.3).clamp(0.0, 1.0))
        .withSaturation((hslColor.saturation * 1.2).clamp(0.0, 1.0));
    return adjustedColor.toColor();
  }

  Color get foreground {
    final hslColor = HSLColor.fromColor(this);
    // Analyzing the transformation from base to foreground color:
    // Base color: 1, 28, 107 (RGB) -> HSL: ~225°, ~0.98, ~0.21
    // Target color: 75, 106, 186 (RGB) -> HSL: ~222°, ~0.42, ~0.51
    // The target is ~2.4x lighter and less saturated
    final adjustedColor = hslColor
        .withLightness((hslColor.lightness * 2.4).clamp(0.0, 1.0))
        .withSaturation((hslColor.saturation * 0.43).clamp(0.0, 1.0));
    return adjustedColor.toColor();
  }

  Color get primary {
    if (this.brightness == Brightness.dark) {
      // For darker colors, create a light gray
      // The value 217 is chosen to match the target for the base color (1,28,107)
      return Color.fromRGBO(217, 217, 217, 1);
    } else {
      // For lighter colors, create a dark gray
      return Color.fromRGBO(38, 38, 38, 1);
    }
  }

  Color get secondary {
    if (this.brightness == Brightness.dark) {
      // For darker colors, create a lighter, less saturated version
      final hslColor = HSLColor.fromColor(this);
      final adjustedColor = hslColor
          .withLightness((hslColor.lightness * 2.3).clamp(0.0, 1.0))
          .withSaturation((hslColor.saturation * 0.18).clamp(0.0, 1.0));
      return adjustedColor.toColor();
    } else {
      // For lighter colors, create a darker, less saturated version
      final hslColor = HSLColor.fromColor(this);
      final adjustedColor = hslColor
          .withLightness((hslColor.lightness * 0.7).clamp(0.0, 1.0))
          .withSaturation((hslColor.saturation * 0.18).clamp(0.0, 1.0));
      return adjustedColor.toColor();
    }
  }

  Color get idInner {
    final hslColor = HSLColor.fromColor(this);
    if (this.brightness == Brightness.dark) {
      // For darker colors, create a lighter, less saturated version (as before)
      final adjustedColor = hslColor
          .withLightness(((hslColor.lightness * 2.6).clamp(0.0, 1.0)))
          .withSaturation(((hslColor.saturation * 0.53).clamp(0.0, 1.0)));
      return adjustedColor.toColor();
    } else {
      // For lighter colors, create a darker, more saturated version (inverse)
      final adjustedColor = hslColor
          .withLightness(((hslColor.lightness * 0.4).clamp(0.0, 1.0)))
          .withSaturation(((hslColor.saturation * 0.53).clamp(0.0, 1.0)));
      return adjustedColor.toColor();
    }
  }

  Color get idOuter {
    return idInner.withAlpha(64); // 0.25 * 255 ≈ 64
  }
}

extension BrightnessExtensions on Color {
  Brightness get brightness {
    return this.computeLuminance() > 0.5 ? Brightness.light : Brightness.dark;
  }
}
