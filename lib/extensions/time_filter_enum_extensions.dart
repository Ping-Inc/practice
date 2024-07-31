import 'package:practice/enums/time_filter_enum.dart';

extension StringParsing on TimeFilterEnum {
  String toTitle() {
    switch (this) {
      case TimeFilterEnum.dayOfMonth:
        return "Day of Month";
      case TimeFilterEnum.month:
        return "Month";
      case TimeFilterEnum.dayOfWeek:
        return "Day of Week";
      case TimeFilterEnum.year:
        return "Year";
    }
  }

  String toDateFormat() {
    switch (this) {
      case TimeFilterEnum.dayOfMonth:
        return "d";
      case TimeFilterEnum.month:
        return "MMMM";
      case TimeFilterEnum.dayOfWeek:
        return "EEEE";
      case TimeFilterEnum.year:
        return "yyyy";
    }
  }
}
