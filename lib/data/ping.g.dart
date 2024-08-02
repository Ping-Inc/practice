// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PingImpl _$$PingImplFromJson(Map<String, dynamic> json) => _$PingImpl(
      id: (json['id'] as num?)?.toInt(),
      time: const DateTimeConverter().fromJson((json['time'] as num).toInt()),
      text: json['text'] as String,
      resonantCount: (json['resonant_count'] as num).toInt(),
      viewCount: (json['view_count'] as num).toInt(),
      hidden:
          const BooleanConverter().fromJson((json['hidden'] as num).toInt()),
      replyId: (json['reply_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PingImplToJson(_$PingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': const DateTimeConverter().toJson(instance.time),
      'text': instance.text,
      'resonant_count': instance.resonantCount,
      'view_count': instance.viewCount,
      'hidden': const BooleanConverter().toJson(instance.hidden),
      'reply_id': instance.replyId,
    };
