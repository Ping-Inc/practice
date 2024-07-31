// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_filtered_pings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timeFilteredPingsHash() => r'6fbfe44f7d5b5d882656874a5b56a2ad1bb02d9b';

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

abstract class _$TimeFilteredPings
    extends BuildlessAutoDisposeAsyncNotifier<List<Ping>> {
  late final TimeFilterEnum timeFilter;
  late final DateTime currentTime;

  FutureOr<List<Ping>> build(
    TimeFilterEnum timeFilter,
    DateTime currentTime,
  );
}

/// See also [TimeFilteredPings].
@ProviderFor(TimeFilteredPings)
const timeFilteredPingsProvider = TimeFilteredPingsFamily();

/// See also [TimeFilteredPings].
class TimeFilteredPingsFamily extends Family<AsyncValue<List<Ping>>> {
  /// See also [TimeFilteredPings].
  const TimeFilteredPingsFamily();

  /// See also [TimeFilteredPings].
  TimeFilteredPingsProvider call(
    TimeFilterEnum timeFilter,
    DateTime currentTime,
  ) {
    return TimeFilteredPingsProvider(
      timeFilter,
      currentTime,
    );
  }

  @override
  TimeFilteredPingsProvider getProviderOverride(
    covariant TimeFilteredPingsProvider provider,
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
  String? get name => r'timeFilteredPingsProvider';
}

/// See also [TimeFilteredPings].
class TimeFilteredPingsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    TimeFilteredPings, List<Ping>> {
  /// See also [TimeFilteredPings].
  TimeFilteredPingsProvider(
    TimeFilterEnum timeFilter,
    DateTime currentTime,
  ) : this._internal(
          () => TimeFilteredPings()
            ..timeFilter = timeFilter
            ..currentTime = currentTime,
          from: timeFilteredPingsProvider,
          name: r'timeFilteredPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timeFilteredPingsHash,
          dependencies: TimeFilteredPingsFamily._dependencies,
          allTransitiveDependencies:
              TimeFilteredPingsFamily._allTransitiveDependencies,
          timeFilter: timeFilter,
          currentTime: currentTime,
        );

  TimeFilteredPingsProvider._internal(
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
  FutureOr<List<Ping>> runNotifierBuild(
    covariant TimeFilteredPings notifier,
  ) {
    return notifier.build(
      timeFilter,
      currentTime,
    );
  }

  @override
  Override overrideWith(TimeFilteredPings Function() create) {
    return ProviderOverride(
      origin: this,
      override: TimeFilteredPingsProvider._internal(
        () => create()
          ..timeFilter = timeFilter
          ..currentTime = currentTime,
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
  AutoDisposeAsyncNotifierProviderElement<TimeFilteredPings, List<Ping>>
      createElement() {
    return _TimeFilteredPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TimeFilteredPingsProvider &&
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

mixin TimeFilteredPingsRef on AutoDisposeAsyncNotifierProviderRef<List<Ping>> {
  /// The parameter `timeFilter` of this provider.
  TimeFilterEnum get timeFilter;

  /// The parameter `currentTime` of this provider.
  DateTime get currentTime;
}

class _TimeFilteredPingsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TimeFilteredPings,
        List<Ping>> with TimeFilteredPingsRef {
  _TimeFilteredPingsProviderElement(super.provider);

  @override
  TimeFilterEnum get timeFilter =>
      (origin as TimeFilteredPingsProvider).timeFilter;
  @override
  DateTime get currentTime => (origin as TimeFilteredPingsProvider).currentTime;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
