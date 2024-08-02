import 'package:freezed_annotation/freezed_annotation.dart';

class BooleanConverter implements JsonConverter<bool, int> {
  const BooleanConverter();

  @override
  bool fromJson(int value) {
    return value == 0 ? false : true;
  }

  @override
  int toJson(bool value) => value ? 1 : 0;
}
