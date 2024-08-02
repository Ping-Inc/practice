import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:practice/data/converters/boolean_converter.dart';
import 'package:practice/data/converters/date_time_converter.dart';

part 'ping.freezed.dart';
part 'ping.g.dart';

@freezed
class Ping with _$Ping {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Ping(
      {int? id,
      @DateTimeConverter() required DateTime time,
      required String text,
      required int resonantCount,
      required int viewCount,
      @BooleanConverter() required bool hidden,
      int? replyId}) = _Ping;

  factory Ping.fromJson(Map<String, dynamic> json) => _$PingFromJson(json);
}
