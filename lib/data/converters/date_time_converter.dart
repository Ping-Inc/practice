import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, int> {
  const DateTimeConverter();

  @override
  DateTime fromJson(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp);

  @override
  int toJson(DateTime time) => time.millisecondsSinceEpoch;
}
