// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ping _$PingFromJson(Map<String, dynamic> json) => _Ping(
      id: (json['id'] as num?)?.toInt(),
      time: const DateTimeConverter().fromJson((json['time'] as num).toInt()),
      text: json['text'] as String,
      replyId: (json['reply_id'] as num?)?.toInt(),
      viewCount: (json['view_count'] as num).toInt(),
      resonantCount: (json['resonant_count'] as num).toInt(),
      hidden:
          const BooleanConverter().fromJson((json['hidden'] as num).toInt()),
      resonantTime: const NullableDateTimeConverter()
          .fromJson((json['resonant_time'] as num?)?.toInt()),
    );

Map<String, dynamic> _$PingToJson(_Ping instance) => <String, dynamic>{
      'id': instance.id,
      'time': const DateTimeConverter().toJson(instance.time),
      'text': instance.text,
      'reply_id': instance.replyId,
      'view_count': instance.viewCount,
      'resonant_count': instance.resonantCount,
      'hidden': const BooleanConverter().toJson(instance.hidden),
      'resonant_time':
          const NullableDateTimeConverter().toJson(instance.resonantTime),
    };
