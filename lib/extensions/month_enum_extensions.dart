import 'package:practice/enums/month_enum.dart';

extension StringParsingExtensions on MonthEnum {
  String title() {
    switch (this) {
      case MonthEnum.january:
        return "january";
      case MonthEnum.february:
        return "february";
      case MonthEnum.march:
        return "march";
      case MonthEnum.april:
        return "april";
      case MonthEnum.may:
        return "may";
      case MonthEnum.june:
        return "june";
      case MonthEnum.july:
        return "july";
      case MonthEnum.august:
        return "august";
      case MonthEnum.september:
        return "september";
      case MonthEnum.october:
        return "october";
      case MonthEnum.november:
        return "november";
      case MonthEnum.december:
        return "december";
    }
  }
}
