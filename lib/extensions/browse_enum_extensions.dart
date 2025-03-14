import 'package:practice/enums/browse_enum.dart';

extension StringParsing on BrowseEnum {
  String title() {
    switch (this) {
      case BrowseEnum.focus:
        return "focus";
      case BrowseEnum.grid:
        return "grid";
    }
  }
}
