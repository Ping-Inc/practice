// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ping_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PingData _$PingDataFromJson(Map<String, dynamic> json) {
  return _Ping.fromJson(json);
}

/// @nodoc
mixin _$PingData {
  int? get id => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get time => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int? get replyId => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get resonantCount => throw _privateConstructorUsedError;
  @BooleanConverter()
  bool get hidden => throw _privateConstructorUsedError;
  @NullableDateTimeConverter()
  DateTime? get resonantTime => throw _privateConstructorUsedError;

  /// Serializes this PingData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PingDataCopyWith<PingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PingDataCopyWith<$Res> {
  factory $PingDataCopyWith(PingData value, $Res Function(PingData) then) =
      _$PingDataCopyWithImpl<$Res, PingData>;
  @useResult
  $Res call(
      {int? id,
      @DateTimeConverter() DateTime time,
      String text,
      int? replyId,
      int viewCount,
      int resonantCount,
      @BooleanConverter() bool hidden,
      @NullableDateTimeConverter() DateTime? resonantTime});
}

/// @nodoc
class _$PingDataCopyWithImpl<$Res, $Val extends PingData>
    implements $PingDataCopyWith<$Res> {
  _$PingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as int?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      resonantCount: null == resonantCount
          ? _value.resonantCount
          : resonantCount // ignore: cast_nullable_to_non_nullable
              as int,
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      resonantTime: freezed == resonantTime
          ? _value.resonantTime
          : resonantTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PingImplCopyWith<$Res> implements $PingDataCopyWith<$Res> {
  factory _$$PingImplCopyWith(
          _$PingImpl value, $Res Function(_$PingImpl) then) =
      __$$PingImplCopyWithImpl<$Res>;
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
      @NullableDateTimeConverter() DateTime? resonantTime});
}

/// @nodoc
class __$$PingImplCopyWithImpl<$Res>
    extends _$PingDataCopyWithImpl<$Res, _$PingImpl>
    implements _$$PingImplCopyWith<$Res> {
  __$$PingImplCopyWithImpl(_$PingImpl _value, $Res Function(_$PingImpl) _then)
      : super(_value, _then);

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
  }) {
    return _then(_$PingImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as int?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      resonantCount: null == resonantCount
          ? _value.resonantCount
          : resonantCount // ignore: cast_nullable_to_non_nullable
              as int,
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      resonantTime: freezed == resonantTime
          ? _value.resonantTime
          : resonantTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PingImpl implements _Ping {
  const _$PingImpl(
      {this.id,
      @DateTimeConverter() required this.time,
      required this.text,
      this.replyId,
      required this.viewCount,
      required this.resonantCount,
      @BooleanConverter() required this.hidden,
      @NullableDateTimeConverter() required this.resonantTime});

  factory _$PingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PingImplFromJson(json);

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
  String toString() {
    return 'PingData(id: $id, time: $time, text: $text, replyId: $replyId, viewCount: $viewCount, resonantCount: $resonantCount, hidden: $hidden, resonantTime: $resonantTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PingImpl &&
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
                other.resonantTime == resonantTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, time, text, replyId,
      viewCount, resonantCount, hidden, resonantTime);

  /// Create a copy of PingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PingImplCopyWith<_$PingImpl> get copyWith =>
      __$$PingImplCopyWithImpl<_$PingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PingImplToJson(
      this,
    );
  }
}

abstract class _Ping implements PingData {
  const factory _Ping(
          {final int? id,
          @DateTimeConverter() required final DateTime time,
          required final String text,
          final int? replyId,
          required final int viewCount,
          required final int resonantCount,
          @BooleanConverter() required final bool hidden,
          @NullableDateTimeConverter() required final DateTime? resonantTime}) =
      _$PingImpl;

  factory _Ping.fromJson(Map<String, dynamic> json) = _$PingImpl.fromJson;

  @override
  int? get id;
  @override
  @DateTimeConverter()
  DateTime get time;
  @override
  String get text;
  @override
  int? get replyId;
  @override
  int get viewCount;
  @override
  int get resonantCount;
  @override
  @BooleanConverter()
  bool get hidden;
  @override
  @NullableDateTimeConverter()
  DateTime? get resonantTime;

  /// Create a copy of PingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PingImplCopyWith<_$PingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
