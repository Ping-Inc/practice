import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:practice/constants.dart';
import 'package:practice/enums/font_enum.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/font_enum_extensions.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';
import 'package:practice/providers/base_color_provider.dart';

class ThemePicker extends ConsumerWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define custom colors with proper names
    // The issue was that the names weren't being respected because we need to use
    // MaterialColor or ColorSwatch<int> for the custom swatches
    final Map<ColorSwatch<Object>, String> customColors = {
      ColorTools.createPrimarySwatch(defaultColor): 'Deep Blue',
      ColorTools.createPrimarySwatch(Color(0xFF03DAC6)): 'Teal',
      ColorTools.createPrimarySwatch(Color(0xFFFF0266)): 'Pink',
      ColorTools.createPrimarySwatch(Color(0xFF2196F3)): 'Blue',
      ColorTools.createPrimarySwatch(Color(0xFF4CAF50)): 'Green',
      ColorTools.createPrimarySwatch(Color(0xFFFFC107)): 'Amber',
      ColorTools.createPrimarySwatch(Color(0xFFFF5722)): 'Deep Orange',
      ColorTools.createPrimarySwatch(Color(0xFF9C27B0)): 'Purple',
      ColorTools.createPrimarySwatch(Color(0xFF673AB7)): 'Deep Purple',
      ColorTools.createPrimarySwatch(Color(0xFF3F51B5)): 'Indigo',
      ColorTools.createPrimarySwatch(Color(0xFF009688)): 'Teal',
      ColorTools.createPrimarySwatch(Color(0xFF8BC34A)): 'Light Green',
      ColorTools.createPrimarySwatch(Color(0xFFCDDC39)): 'Lime',
      ColorTools.createPrimarySwatch(Color(0xFFFF9800)): 'Orange',
      ColorTools.createPrimarySwatch(Color(0xFF795548)): 'Brown',
      ColorTools.createPrimarySwatch(Color(0xFF607D8B)): 'Blue Grey'
    };

    return ColorPicker(
      padding: EdgeInsets.only(
          top: spacingSmall, bottom: spacingSmall, right: spacingXSmall),
      color: Theme.of(context).colorScheme.surface,
      onColorChanged: (color) =>
          ref.read(baseColorProvider.notifier).setColor(color),
      enableOpacity: false,
      enableShadesSelection: false,
      colorNameTextStyle: TextStyle(
        fontFamily: FontEnum.sfmono.toFontFamily(),
        fontSize: TextSizeEnum.twelve.toFontSize(),
        color: Theme.of(context).colorScheme.outline,
      ),
      showColorName: true,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.custom: true,
      },
      customColorSwatchesAndNames: customColors,
    );
  }
}
