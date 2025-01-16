// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_of_day_pings_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timeOfDayPingsCountHash() =>
    r'6124c5a620216d72682de62eb8fcf7ae54f3685c';

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

/// See also [timeOfDayPingsCount].
@ProviderFor(timeOfDayPingsCount)
const timeOfDayPingsCountProvider = TimeOfDayPingsCountFamily();

/// See also [timeOfDayPingsCount].
class TimeOfDayPingsCountFamily extends Family<AsyncValue<int>> {
  /// See also [timeOfDayPingsCount].
  const TimeOfDayPingsCountFamily();

  /// See also [timeOfDayPingsCount].
  TimeOfDayPingsCountProvider call(
    TimeFilterEnum timeFilter,
    DateTime currentTime,
  ) {
    return TimeOfDayPingsCountProvider(
      timeFilter,
      currentTime,
    );
  }

  @override
  TimeOfDayPingsCountProvider getProviderOverride(
    covariant TimeOfDayPingsCountProvider provider,
  ) {
    return call(
      provider.timeFilter,
      provider.currentTime,
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
  String? get name => r'timeOfDayPingsCountProvider';
}

/// See also [timeOfDayPingsCount].
class TimeOfDayPingsCountProvider extends AutoDisposeFutureProvider<int> {
  /// See also [timeOfDayPingsCount].
  TimeOfDayPingsCountProvider(
    TimeFilterEnum timeFilter,
    DateTime currentTime,
  ) : this._internal(
          (ref) => timeOfDayPingsCount(
            ref as TimeOfDayPingsCountRef,
            timeFilter,
            currentTime,
          ),
          from: timeOfDayPingsCountProvider,
          name: r'timeOfDayPingsCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timeOfDayPingsCountHash,
          dependencies: TimeOfDayPingsCountFamily._dependencies,
          allTransitiveDependencies:
              TimeOfDayPingsCountFamily._allTransitiveDependencies,
          timeFilter: timeFilter,
          currentTime: currentTime,
        );

  TimeOfDayPingsCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.timeFilter,
    required this.currentTime,
  }) : super.internal();

  final TimeFilterEnum timeFilter;
  final DateTime currentTime;

  @override
  Override overrideWith(
    FutureOr<int> Function(TimeOfDayPingsCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TimeOfDayPingsCountProvider._internal(
        (ref) => create(ref as TimeOfDayPingsCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        timeFilter: timeFilter,
        currentTime: currentTime,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _TimeOfDayPingsCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TimeOfDayPingsCountProvider &&
        other.timeFilter == timeFilter &&
        other.currentTime == currentTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, timeFilter.hashCode);
    hash = _SystemHash.combine(hash, currentTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TimeOfDayPingsCountRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `timeFilter` of this provider.
  TimeFilterEnum get timeFilter;

  /// The parameter `currentTime` of this provider.
  DateTime get currentTime;
}

class _TimeOfDayPingsCountProviderElement
    extends AutoDisposeFutureProviderElement<int> with TimeOfDayPingsCountRef {
  _TimeOfDayPingsCountProviderElement(super.provider);

  @override
  TimeFilterEnum get timeFilter =>
      (origin as TimeOfDayPingsCountProvider).timeFilter;
  @override
  DateTime get currentTime =>
      (origin as TimeOfDayPingsCountProvider).currentTime;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
