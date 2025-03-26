import 'package:practice/enums/browse_enum.dart';

extension StringParsing on BrowseEnum {
  String title() {
    switch (this) {
      case BrowseEnum.focus:
        return "Focus";
      case BrowseEnum.grid:
        return "Grid";
    }
  }
}
