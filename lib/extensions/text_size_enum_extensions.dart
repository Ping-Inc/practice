import 'package:practice/enums/text_size_enum.dart';

extension DoubleParsing on TextSizeEnum {
  double toFontSize() {
    switch (this) {
      case TextSizeEnum.twelve:
        return 12;
      case TextSizeEnum.fifteen:
        return 15;
      case TextSizeEnum.twenty:
        return 20;
      case TextSizeEnum.twentyNine:
        return 29;
      case TextSizeEnum.thirtySix:
        return 36;
    }
  }
}
