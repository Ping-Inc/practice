import 'package:json_annotation/json_annotation.dart';
import 'package:practice/data/converters/date_time_converter.dart';

class NullableDateTimeConverter implements JsonConverter<DateTime?, int?> {
  const NullableDateTimeConverter();

  @override
  DateTime? fromJson(int? timestamp) =>
      timestamp != null ? DateTimeConverter().fromJson(timestamp) : null;

  @override
  int? toJson(DateTime? time) =>
      time != null ? DateTimeConverter().toJson(time) : null;
}
