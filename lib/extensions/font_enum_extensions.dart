import 'package:practice/enums/font_enum.dart';

extension StringParsing on FontEnum {
  String toFontFamily() {
    switch (this) {
      case FontEnum.garamond:
        return "Garamond";
      case FontEnum.sfpro:
        return "SF-Pro";
      case FontEnum.sfmono:
        return "SF-Mono";
      case FontEnum.courier:
        return "Courier";
    }
  }
}
