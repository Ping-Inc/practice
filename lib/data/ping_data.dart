import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:practice/data/converters/boolean_converter.dart';
import 'package:practice/data/converters/date_time_converter.dart';
import 'package:practice/data/converters/nullable_date_time_converter.dart';

part 'ping_data.freezed.dart';
part 'ping_data.g.dart';

@freezed
abstract class PingData with _$PingData {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PingData({
    int? id,
    @DateTimeConverter() required DateTime time,
    required String text,
    int? replyId,
    required int viewCount,
    required int resonantCount,
    @BooleanConverter() required bool hidden,
    @NullableDateTimeConverter() required DateTime? resonantTime,
    @BooleanConverter() @Default(false) bool isPlaced,
    @NullableDateTimeConverter() DateTime? placedTime,
    // Non-null means the ping is public; it's when it was made public.
    @NullableDateTimeConverter() DateTime? publicTime,
  }) = _Ping;

  const PingData._();

  bool get isPublic => publicTime != null;

  // A ping can be made public once it's 24 hours old.
  bool canBePublic(DateTime now) =>
      now.difference(time) >= const Duration(hours: 24);

  factory PingData.fromJson(Map<String, dynamic> json) =>
      _$PingDataFromJson(json);
}
