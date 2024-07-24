import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:practice/enums/sub_pages_enum.dart';

extension IconParsing on SubPagesEnum {
  IconData icon() {
    switch (this) {
      case SubPagesEnum.browse:
        return PhosphorIcons.file;
      case SubPagesEnum.search:
        return PhosphorIcons.magnifying_glass;
      case SubPagesEnum.settings:
        return PhosphorIcons.gear;
      case SubPagesEnum.add:
        return PhosphorIcons.plus;
    }
  }

  IconData iconFilled() {
    switch (this) {
      case SubPagesEnum.browse:
        return PhosphorIcons.file_bold;
      case SubPagesEnum.search:
        return PhosphorIcons.magnifying_glass_bold;
      case SubPagesEnum.settings:
        return PhosphorIcons.gear_bold;
      case SubPagesEnum.add:
        return PhosphorIcons.plus_bold;
    }
  }
}
