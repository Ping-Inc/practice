// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_filter_increment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timeFilterIncrementHash() =>
    r'f715e6f2ed29c489a5298a4976507ba18495382b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TimeFilterIncrement
    extends BuildlessAutoDisposeNotifier<DateTime> {
  late final DateTime time;

  DateTime build(
    DateTime time,
  );
}

/// See also [TimeFilterIncrement].
@ProviderFor(TimeFilterIncrement)
const timeFilterIncrementProvider = TimeFilterIncrementFamily();

/// See also [TimeFilterIncrement].
class TimeFilterIncrementFamily extends Family<DateTime> {
  /// See also [TimeFilterIncrement].
  const TimeFilterIncrementFamily();

  /// See also [TimeFilterIncrement].
  TimeFilterIncrementProvider call(
    DateTime time,
  ) {
    return TimeFilterIncrementProvider(
      time,
    );
  }

  @override
  TimeFilterIncrementProvider getProviderOverride(
    covariant TimeFilterIncrementProvider provider,
  ) {
    return call(
      provider.time,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'timeFilterIncrementProvider';
}

/// See also [TimeFilterIncrement].
class TimeFilterIncrementProvider
    extends AutoDisposeNotifierProviderImpl<TimeFilterIncrement, DateTime> {
  /// See also [TimeFilterIncrement].
  TimeFilterIncrementProvider(
    DateTime time,
  ) : this._internal(
          () => TimeFilterIncrement()..time = time,
          from: timeFilterIncrementProvider,
          name: r'timeFilterIncrementProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timeFilterIncrementHash,
          dependencies: TimeFilterIncrementFamily._dependencies,
          allTransitiveDependencies:
              TimeFilterIncrementFamily._allTransitiveDependencies,
          time: time,
        );

  TimeFilterIncrementProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.time,
  }) : super.internal();

  final DateTime time;

  @override
  DateTime runNotifierBuild(
    covariant TimeFilterIncrement notifier,
  ) {
    return notifier.build(
      time,
    );
  }

  @override
  Override overrideWith(TimeFilterIncrement Function() create) {
    return ProviderOverride(
      origin: this,
      override: TimeFilterIncrementProvider._internal(
        () => create()..time = time,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        time: time,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TimeFilterIncrement, DateTime>
      createElement() {
    return _TimeFilterIncrementProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TimeFilterIncrementProvider && other.time == time;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, time.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TimeFilterIncrementRef on AutoDisposeNotifierProviderRef<DateTime> {
  /// The parameter `time` of this provider.
  DateTime get time;
}

class _TimeFilterIncrementProviderElement
    extends AutoDisposeNotifierProviderElement<TimeFilterIncrement, DateTime>
    with TimeFilterIncrementRef {
  _TimeFilterIncrementProviderElement(super.provider);

  @override
  DateTime get time => (origin as TimeFilterIncrementProvider).time;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
