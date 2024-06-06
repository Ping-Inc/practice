import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:practice/data/converters/date_time_converter.dart';

part 'ping.freezed.dart';
part 'ping.g.dart';

@freezed
class Ping with _$Ping {
  const factory Ping(
      {int? id,
      @DateTimeConverter() required DateTime time,
      required String text}) = _Ping;

  factory Ping.fromJson(Map<String, dynamic> json) => _$PingFromJson(json);
}
