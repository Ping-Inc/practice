// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ping.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Ping _$PingFromJson(Map<String, dynamic> json) {
  return _Ping.fromJson(json);
}

/// @nodoc
mixin _$Ping {
  int? get id => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get time => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PingCopyWith<Ping> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PingCopyWith<$Res> {
  factory $PingCopyWith(Ping value, $Res Function(Ping) then) =
      _$PingCopyWithImpl<$Res, Ping>;
  @useResult
  $Res call({int? id, @DateTimeConverter() DateTime time, String text});
}

/// @nodoc
class _$PingCopyWithImpl<$Res, $Val extends Ping>
    implements $PingCopyWith<$Res> {
  _$PingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? time = null,
    Object? text = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PingImplCopyWith<$Res> implements $PingCopyWith<$Res> {
  factory _$$PingImplCopyWith(
          _$PingImpl value, $Res Function(_$PingImpl) then) =
      __$$PingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, @DateTimeConverter() DateTime time, String text});
}

/// @nodoc
class __$$PingImplCopyWithImpl<$Res>
    extends _$PingCopyWithImpl<$Res, _$PingImpl>
    implements _$$PingImplCopyWith<$Res> {
  __$$PingImplCopyWithImpl(_$PingImpl _value, $Res Function(_$PingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? time = null,
    Object? text = null,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PingImpl implements _Ping {
  const _$PingImpl(
      {this.id, @DateTimeConverter() required this.time, required this.text});

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
  String toString() {
    return 'Ping(id: $id, time: $time, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, time, text);

  @JsonKey(ignore: true)
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

abstract class _Ping implements Ping {
  const factory _Ping(
      {final int? id,
      @DateTimeConverter() required final DateTime time,
      required final String text}) = _$PingImpl;

  factory _Ping.fromJson(Map<String, dynamic> json) = _$PingImpl.fromJson;

  @override
  int? get id;
  @override
  @DateTimeConverter()
  DateTime get time;
  @override
  String get text;
  @override
  @JsonKey(ignore: true)
  _$$PingImplCopyWith<_$PingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
