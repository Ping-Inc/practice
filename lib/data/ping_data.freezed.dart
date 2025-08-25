// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ping_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
PingData _$PingDataFromJson(Map<String, dynamic> json) {
  return _Ping.fromJson(json);
}

/// @nodoc
mixin _$PingData {
  int? get id;
  @DateTimeConverter()
  DateTime get time;
  String get text;
  int? get replyId;
  int get viewCount;
  int get resonantCount;
  @BooleanConverter()
  bool get hidden;
  @NullableDateTimeConverter()
  DateTime? get resonantTime;
  @BooleanConverter()
  bool get isPlaced;
  @NullableDateTimeConverter()
  DateTime? get placedTime;

  /// Create a copy of PingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PingDataCopyWith<PingData> get copyWith =>
      _$PingDataCopyWithImpl<PingData>(this as PingData, _$identity);

  /// Serializes this PingData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PingData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.resonantCount, resonantCount) ||
                other.resonantCount == resonantCount) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            (identical(other.resonantTime, resonantTime) ||
                other.resonantTime == resonantTime) &&
            (identical(other.isPlaced, isPlaced) ||
                other.isPlaced == isPlaced) &&
            (identical(other.placedTime, placedTime) ||
                other.placedTime == placedTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, time, text, replyId,
      viewCount, resonantCount, hidden, resonantTime, isPlaced, placedTime);

  @override
  String toString() {
    return 'PingData(id: $id, time: $time, text: $text, replyId: $replyId, viewCount: $viewCount, resonantCount: $resonantCount, hidden: $hidden, resonantTime: $resonantTime, isPlaced: $isPlaced, placedTime: $placedTime)';
  }
}

/// @nodoc
abstract mixin class $PingDataCopyWith<$Res> {
  factory $PingDataCopyWith(PingData value, $Res Function(PingData) _then) =
      _$PingDataCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      @DateTimeConverter() DateTime time,
      String text,
      int? replyId,
      int viewCount,
      int resonantCount,
      @BooleanConverter() bool hidden,
      @NullableDateTimeConverter() DateTime? resonantTime,
      @BooleanConverter() bool isPlaced,
      @NullableDateTimeConverter() DateTime? placedTime});
}

/// @nodoc
class _$PingDataCopyWithImpl<$Res> implements $PingDataCopyWith<$Res> {
  _$PingDataCopyWithImpl(this._self, this._then);

  final PingData _self;
  final $Res Function(PingData) _then;

  /// Create a copy of PingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? time = null,
    Object? text = null,
    Object? replyId = freezed,
    Object? viewCount = null,
    Object? resonantCount = null,
    Object? hidden = null,
    Object? resonantTime = freezed,
    Object? isPlaced = null,
    Object? placedTime = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      replyId: freezed == replyId
          ? _self.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as int?,
      viewCount: null == viewCount
          ? _self.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      resonantCount: null == resonantCount
          ? _self.resonantCount
          : resonantCount // ignore: cast_nullable_to_non_nullable
              as int,
      hidden: null == hidden
          ? _self.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      resonantTime: freezed == resonantTime
          ? _self.resonantTime
          : resonantTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPlaced: null == isPlaced
          ? _self.isPlaced
          : isPlaced // ignore: cast_nullable_to_non_nullable
              as bool,
      placedTime: freezed == placedTime
          ? _self.placedTime
          : placedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Ping implements PingData {
  const _Ping(
      {this.id,
      @DateTimeConverter() required this.time,
      required this.text,
      this.replyId,
      required this.viewCount,
      required this.resonantCount,
      @BooleanConverter() required this.hidden,
      @NullableDateTimeConverter() required this.resonantTime,
      @BooleanConverter() this.isPlaced = false,
      @NullableDateTimeConverter() this.placedTime});
  factory _Ping.fromJson(Map<String, dynamic> json) => _$PingFromJson(json);

  @override
  final int? id;
  @override
  @DateTimeConverter()
  final DateTime time;
  @override
  final String text;
  @override
  final int? replyId;
  @override
  final int viewCount;
  @override
  final int resonantCount;
  @override
  @BooleanConverter()
  final bool hidden;
  @override
  @NullableDateTimeConverter()
  final DateTime? resonantTime;
  @override
  @JsonKey()
  @BooleanConverter()
  final bool isPlaced;
  @override
  @NullableDateTimeConverter()
  final DateTime? placedTime;

  /// Create a copy of PingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PingCopyWith<_Ping> get copyWith =>
      __$PingCopyWithImpl<_Ping>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Ping &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.resonantCount, resonantCount) ||
                other.resonantCount == resonantCount) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            (identical(other.resonantTime, resonantTime) ||
                other.resonantTime == resonantTime) &&
            (identical(other.isPlaced, isPlaced) ||
                other.isPlaced == isPlaced) &&
            (identical(other.placedTime, placedTime) ||
                other.placedTime == placedTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, time, text, replyId,
      viewCount, resonantCount, hidden, resonantTime, isPlaced, placedTime);

  @override
  String toString() {
    return 'PingData(id: $id, time: $time, text: $text, replyId: $replyId, viewCount: $viewCount, resonantCount: $resonantCount, hidden: $hidden, resonantTime: $resonantTime, isPlaced: $isPlaced, placedTime: $placedTime)';
  }
}

/// @nodoc
abstract mixin class _$PingCopyWith<$Res> implements $PingDataCopyWith<$Res> {
  factory _$PingCopyWith(_Ping value, $Res Function(_Ping) _then) =
      __$PingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      @DateTimeConverter() DateTime time,
      String text,
      int? replyId,
      int viewCount,
      int resonantCount,
      @BooleanConverter() bool hidden,
      @NullableDateTimeConverter() DateTime? resonantTime,
      @BooleanConverter() bool isPlaced,
      @NullableDateTimeConverter() DateTime? placedTime});
}

/// @nodoc
class __$PingCopyWithImpl<$Res> implements _$PingCopyWith<$Res> {
  __$PingCopyWithImpl(this._self, this._then);

  final _Ping _self;
  final $Res Function(_Ping) _then;

  /// Create a copy of PingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? time = null,
    Object? text = null,
    Object? replyId = freezed,
    Object? viewCount = null,
    Object? resonantCount = null,
    Object? hidden = null,
    Object? resonantTime = freezed,
    Object? isPlaced = null,
    Object? placedTime = freezed,
  }) {
    return _then(_Ping(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      replyId: freezed == replyId
          ? _self.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as int?,
      viewCount: null == viewCount
          ? _self.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      resonantCount: null == resonantCount
          ? _self.resonantCount
          : resonantCount // ignore: cast_nullable_to_non_nullable
              as int,
      hidden: null == hidden
          ? _self.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      resonantTime: freezed == resonantTime
          ? _self.resonantTime
          : resonantTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPlaced: null == isPlaced
          ? _self.isPlaced
          : isPlaced // ignore: cast_nullable_to_non_nullable
              as bool,
      placedTime: freezed == placedTime
          ? _self.placedTime
          : placedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
