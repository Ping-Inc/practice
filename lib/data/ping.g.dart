// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PingImpl _$$PingImplFromJson(Map<String, dynamic> json) => _$PingImpl(
      id: (json['id'] as num?)?.toInt(),
      time: const DateTimeConverter().fromJson((json['time'] as num).toInt()),
      text: json['text'] as String,
    );

Map<String, dynamic> _$$PingImplToJson(_$PingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': const DateTimeConverter().toJson(instance.time),
      'text': instance.text,
    };
