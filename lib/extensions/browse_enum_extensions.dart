import 'package:practice/enums/browse_enum.dart';

extension StringParsing on BrowseEnum {
  String title() {
    switch (this) {
      case BrowseEnum.slides:
        return "Slides";
      case BrowseEnum.list:
        return "List";
    }
  }
}
