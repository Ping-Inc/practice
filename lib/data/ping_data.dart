import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:practice/data/converters/boolean_converter.dart';
import 'package:practice/data/converters/date_time_converter.dart';

part 'ping_data.freezed.dart';
part 'ping_data.g.dart';

@freezed
class PingData with _$PingData {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PingData(
      {int? id,
      @DateTimeConverter() required DateTime time,
      required String text,
      required int resonantCount,
      required int viewCount,
      @BooleanConverter() required bool hidden,
      int? replyId}) = _Ping;

  factory PingData.fromJson(Map<String, dynamic> json) =>
      _$PingDataFromJson(json);
}
