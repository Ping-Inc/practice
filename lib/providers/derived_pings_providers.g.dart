// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'derived_pings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allPingsHash() => r'e979e756e37153a0f42fb0a0d1697e26536bc244';

/// See also [allPings].
@ProviderFor(allPings)
final allPingsProvider = AutoDisposeProvider<List<PingData>>.internal(
  allPings,
  name: r'allPingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allPingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllPingsRef = AutoDisposeProviderRef<List<PingData>>;
String _$resonatedPingsHash() => r'0c13b98bf5c8dead7ef39c0a4d5f1205f798f54d';

/// See also [resonatedPings].
@ProviderFor(resonatedPings)
final resonatedPingsProvider = AutoDisposeProvider<List<PingData>>.internal(
  resonatedPings,
  name: r'resonatedPingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resonatedPingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResonatedPingsRef = AutoDisposeProviderRef<List<PingData>>;
String _$hiddenPingsHash() => r'b046a3812399f2e471be1de5269ff19116ec5886';

/// See also [hiddenPings].
@ProviderFor(hiddenPings)
final hiddenPingsProvider = AutoDisposeProvider<List<PingData>>.internal(
  hiddenPings,
  name: r'hiddenPingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$hiddenPingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HiddenPingsRef = AutoDisposeProviderRef<List<PingData>>;
String _$pingRepliesHash() => r'582e2875a015f3b612288d14ec7c9513951d78a0';

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

/// See also [pingReplies].
@ProviderFor(pingReplies)
const pingRepliesProvider = PingRepliesFamily();

/// See also [pingReplies].
class PingRepliesFamily extends Family<List<PingData>> {
  /// See also [pingReplies].
  const PingRepliesFamily();

  /// See also [pingReplies].
  PingRepliesProvider call(
    int pingId,
  ) {
    return PingRepliesProvider(
      pingId,
    );
  }

  @override
  PingRepliesProvider getProviderOverride(
    covariant PingRepliesProvider provider,
  ) {
    return call(
      provider.pingId,
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
  String? get name => r'pingRepliesProvider';
}

/// See also [pingReplies].
class PingRepliesProvider extends AutoDisposeProvider<List<PingData>> {
  /// See also [pingReplies].
  PingRepliesProvider(
    int pingId,
  ) : this._internal(
          (ref) => pingReplies(
            ref as PingRepliesRef,
            pingId,
          ),
          from: pingRepliesProvider,
          name: r'pingRepliesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pingRepliesHash,
          dependencies: PingRepliesFamily._dependencies,
          allTransitiveDependencies:
              PingRepliesFamily._allTransitiveDependencies,
          pingId: pingId,
        );

  PingRepliesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pingId,
  }) : super.internal();

  final int pingId;

  @override
  Override overrideWith(
    List<PingData> Function(PingRepliesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PingRepliesProvider._internal(
        (ref) => create(ref as PingRepliesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pingId: pingId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _PingRepliesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PingRepliesProvider && other.pingId == pingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PingRepliesRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `pingId` of this provider.
  int get pingId;
}

class _PingRepliesProviderElement
    extends AutoDisposeProviderElement<List<PingData>> with PingRepliesRef {
  _PingRepliesProviderElement(super.provider);

  @override
  int get pingId => (origin as PingRepliesProvider).pingId;
}

String _$latestPingHash() => r'b8f5495e02760ffb67e00102981e0e0a39e7cac8';

/// See also [latestPing].
@ProviderFor(latestPing)
final latestPingProvider = AutoDisposeProvider<PingData?>.internal(
  latestPing,
  name: r'latestPingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$latestPingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestPingRef = AutoDisposeProviderRef<PingData?>;
String _$modeFilteredPingsHash() => r'c5aab2a9649c2589e10303875696e19dd1fd8afc';

/// See also [modeFilteredPings].
@ProviderFor(modeFilteredPings)
const modeFilteredPingsProvider = ModeFilteredPingsFamily();

/// See also [modeFilteredPings].
class ModeFilteredPingsFamily extends Family<List<PingData>> {
  /// See also [modeFilteredPings].
  const ModeFilteredPingsFamily();

  /// See also [modeFilteredPings].
  ModeFilteredPingsProvider call(
    String mode,
  ) {
    return ModeFilteredPingsProvider(
      mode,
    );
  }

  @override
  ModeFilteredPingsProvider getProviderOverride(
    covariant ModeFilteredPingsProvider provider,
  ) {
    return call(
      provider.mode,
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
  String? get name => r'modeFilteredPingsProvider';
}

/// See also [modeFilteredPings].
class ModeFilteredPingsProvider extends AutoDisposeProvider<List<PingData>> {
  /// See also [modeFilteredPings].
  ModeFilteredPingsProvider(
    String mode,
  ) : this._internal(
          (ref) => modeFilteredPings(
            ref as ModeFilteredPingsRef,
            mode,
          ),
          from: modeFilteredPingsProvider,
          name: r'modeFilteredPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$modeFilteredPingsHash,
          dependencies: ModeFilteredPingsFamily._dependencies,
          allTransitiveDependencies:
              ModeFilteredPingsFamily._allTransitiveDependencies,
          mode: mode,
        );

  ModeFilteredPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mode,
  }) : super.internal();

  final String mode;

  @override
  Override overrideWith(
    List<PingData> Function(ModeFilteredPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ModeFilteredPingsProvider._internal(
        (ref) => create(ref as ModeFilteredPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mode: mode,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _ModeFilteredPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ModeFilteredPingsProvider && other.mode == mode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ModeFilteredPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `mode` of this provider.
  String get mode;
}

class _ModeFilteredPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>>
    with ModeFilteredPingsRef {
  _ModeFilteredPingsProviderElement(super.provider);

  @override
  String get mode => (origin as ModeFilteredPingsProvider).mode;
}

String _$dayOfWeekPingsHash() => r'526a5f6ef40a8aeafc10f30258576ec2b55cd954';

/// See also [dayOfWeekPings].
@ProviderFor(dayOfWeekPings)
const dayOfWeekPingsProvider = DayOfWeekPingsFamily();

/// See also [dayOfWeekPings].
class DayOfWeekPingsFamily extends Family<List<PingData>> {
  /// See also [dayOfWeekPings].
  const DayOfWeekPingsFamily();

  /// See also [dayOfWeekPings].
  DayOfWeekPingsProvider call(
    int weekday,
  ) {
    return DayOfWeekPingsProvider(
      weekday,
    );
  }

  @override
  DayOfWeekPingsProvider getProviderOverride(
    covariant DayOfWeekPingsProvider provider,
  ) {
    return call(
      provider.weekday,
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
  String? get name => r'dayOfWeekPingsProvider';
}

/// See also [dayOfWeekPings].
class DayOfWeekPingsProvider extends AutoDisposeProvider<List<PingData>> {
  /// See also [dayOfWeekPings].
  DayOfWeekPingsProvider(
    int weekday,
  ) : this._internal(
          (ref) => dayOfWeekPings(
            ref as DayOfWeekPingsRef,
            weekday,
          ),
          from: dayOfWeekPingsProvider,
          name: r'dayOfWeekPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dayOfWeekPingsHash,
          dependencies: DayOfWeekPingsFamily._dependencies,
          allTransitiveDependencies:
              DayOfWeekPingsFamily._allTransitiveDependencies,
          weekday: weekday,
        );

  DayOfWeekPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.weekday,
  }) : super.internal();

  final int weekday;

  @override
  Override overrideWith(
    List<PingData> Function(DayOfWeekPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DayOfWeekPingsProvider._internal(
        (ref) => create(ref as DayOfWeekPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        weekday: weekday,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _DayOfWeekPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DayOfWeekPingsProvider && other.weekday == weekday;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, weekday.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DayOfWeekPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `weekday` of this provider.
  int get weekday;
}

class _DayOfWeekPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>> with DayOfWeekPingsRef {
  _DayOfWeekPingsProviderElement(super.provider);

  @override
  int get weekday => (origin as DayOfWeekPingsProvider).weekday;
}

String _$monthPingsHash() => r'a98c5b42700a2b75c78be50187cb0c8b4f732318';

/// See also [monthPings].
@ProviderFor(monthPings)
const monthPingsProvider = MonthPingsFamily();

/// See also [monthPings].
class MonthPingsFamily extends Family<List<PingData>> {
  /// See also [monthPings].
  const MonthPingsFamily();

  /// See also [monthPings].
  MonthPingsProvider call(
    int month,
  ) {
    return MonthPingsProvider(
      month,
    );
  }

  @override
  MonthPingsProvider getProviderOverride(
    covariant MonthPingsProvider provider,
  ) {
    return call(
      provider.month,
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
  String? get name => r'monthPingsProvider';
}

/// See also [monthPings].
class MonthPingsProvider extends AutoDisposeProvider<List<PingData>> {
  /// See also [monthPings].
  MonthPingsProvider(
    int month,
  ) : this._internal(
          (ref) => monthPings(
            ref as MonthPingsRef,
            month,
          ),
          from: monthPingsProvider,
          name: r'monthPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthPingsHash,
          dependencies: MonthPingsFamily._dependencies,
          allTransitiveDependencies:
              MonthPingsFamily._allTransitiveDependencies,
          month: month,
        );

  MonthPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
  }) : super.internal();

  final int month;

  @override
  Override overrideWith(
    List<PingData> Function(MonthPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthPingsProvider._internal(
        (ref) => create(ref as MonthPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _MonthPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthPingsProvider && other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `month` of this provider.
  int get month;
}

class _MonthPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>> with MonthPingsRef {
  _MonthPingsProviderElement(super.provider);

  @override
  int get month => (origin as MonthPingsProvider).month;
}

String _$dayOfMonthPingsHash() => r'75fc8ba5cabc289f89a24f9590fb7fc1a3588d70';

/// See also [dayOfMonthPings].
@ProviderFor(dayOfMonthPings)
const dayOfMonthPingsProvider = DayOfMonthPingsFamily();

/// See also [dayOfMonthPings].
class DayOfMonthPingsFamily extends Family<List<PingData>> {
  /// See also [dayOfMonthPings].
  const DayOfMonthPingsFamily();

  /// See also [dayOfMonthPings].
  DayOfMonthPingsProvider call(
    int day,
  ) {
    return DayOfMonthPingsProvider(
      day,
    );
  }

  @override
  DayOfMonthPingsProvider getProviderOverride(
    covariant DayOfMonthPingsProvider provider,
  ) {
    return call(
      provider.day,
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
  String? get name => r'dayOfMonthPingsProvider';
}

/// See also [dayOfMonthPings].
class DayOfMonthPingsProvider extends AutoDisposeProvider<List<PingData>> {
  /// See also [dayOfMonthPings].
  DayOfMonthPingsProvider(
    int day,
  ) : this._internal(
          (ref) => dayOfMonthPings(
            ref as DayOfMonthPingsRef,
            day,
          ),
          from: dayOfMonthPingsProvider,
          name: r'dayOfMonthPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dayOfMonthPingsHash,
          dependencies: DayOfMonthPingsFamily._dependencies,
          allTransitiveDependencies:
              DayOfMonthPingsFamily._allTransitiveDependencies,
          day: day,
        );

  DayOfMonthPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.day,
  }) : super.internal();

  final int day;

  @override
  Override overrideWith(
    List<PingData> Function(DayOfMonthPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DayOfMonthPingsProvider._internal(
        (ref) => create(ref as DayOfMonthPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _DayOfMonthPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DayOfMonthPingsProvider && other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DayOfMonthPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `day` of this provider.
  int get day;
}

class _DayOfMonthPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>> with DayOfMonthPingsRef {
  _DayOfMonthPingsProviderElement(super.provider);

  @override
  int get day => (origin as DayOfMonthPingsProvider).day;
}

String _$yearPingsHash() => r'b9689f733a3c5db0f08512467dcf16d150658f2f';

/// See also [yearPings].
@ProviderFor(yearPings)
const yearPingsProvider = YearPingsFamily();

/// See also [yearPings].
class YearPingsFamily extends Family<List<PingData>> {
  /// See also [yearPings].
  const YearPingsFamily();

  /// See also [yearPings].
  YearPingsProvider call(
    int year,
  ) {
    return YearPingsProvider(
      year,
    );
  }

  @override
  YearPingsProvider getProviderOverride(
    covariant YearPingsProvider provider,
  ) {
    return call(
      provider.year,
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
  String? get name => r'yearPingsProvider';
}

/// See also [yearPings].
class YearPingsProvider extends AutoDisposeProvider<List<PingData>> {
  /// See also [yearPings].
  YearPingsProvider(
    int year,
  ) : this._internal(
          (ref) => yearPings(
            ref as YearPingsRef,
            year,
          ),
          from: yearPingsProvider,
          name: r'yearPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$yearPingsHash,
          dependencies: YearPingsFamily._dependencies,
          allTransitiveDependencies: YearPingsFamily._allTransitiveDependencies,
          year: year,
        );

  YearPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
  }) : super.internal();

  final int year;

  @override
  Override overrideWith(
    List<PingData> Function(YearPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: YearPingsProvider._internal(
        (ref) => create(ref as YearPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _YearPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YearPingsProvider && other.year == year;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin YearPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `year` of this provider.
  int get year;
}

class _YearPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>> with YearPingsRef {
  _YearPingsProviderElement(super.provider);

  @override
  int get year => (origin as YearPingsProvider).year;
}

String _$lastWeekPingsHash() => r'af533dfd390c1dfd10cb30cc4318f0a9db7e9c4f';

/// See also [lastWeekPings].
@ProviderFor(lastWeekPings)
final lastWeekPingsProvider = AutoDisposeProvider<List<PingData>>.internal(
  lastWeekPings,
  name: r'lastWeekPingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lastWeekPingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LastWeekPingsRef = AutoDisposeProviderRef<List<PingData>>;
String _$pingYearsHash() => r'663e2baeb3eee15f1127a2cdbb9cf141a567085c';

/// See also [pingYears].
@ProviderFor(pingYears)
final pingYearsProvider = AutoDisposeProvider<List<int>>.internal(
  pingYears,
  name: r'pingYearsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pingYearsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PingYearsRef = AutoDisposeProviderRef<List<int>>;
String _$placedPingsHash() => r'3be438d42ba56901e451303fd7bbb7c48c98d329';

/// See also [placedPings].
@ProviderFor(placedPings)
final placedPingsProvider = AutoDisposeProvider<List<PingData>>.internal(
  placedPings,
  name: r'placedPingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$placedPingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PlacedPingsRef = AutoDisposeProviderRef<List<PingData>>;
String _$anyPlacedHash() => r'5241c0f9606e3d1cc53915810cafdd09b703e87e';

/// See also [anyPlaced].
@ProviderFor(anyPlaced)
final anyPlacedProvider = AutoDisposeProvider<bool>.internal(
  anyPlaced,
  name: r'anyPlacedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$anyPlacedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnyPlacedRef = AutoDisposeProviderRef<bool>;
String _$mostRecentPlacedPingHash() =>
    r'71ae51ebc99fc1ef767df8209dd497aef6f55def';

/// See also [mostRecentPlacedPing].
@ProviderFor(mostRecentPlacedPing)
final mostRecentPlacedPingProvider = AutoDisposeProvider<PingData?>.internal(
  mostRecentPlacedPing,
  name: r'mostRecentPlacedPingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mostRecentPlacedPingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MostRecentPlacedPingRef = AutoDisposeProviderRef<PingData?>;
String _$anyResonatedHash() => r'3a96e105a70f00822d254100d6376c07db4ceada';

/// See also [anyResonated].
@ProviderFor(anyResonated)
final anyResonatedProvider = AutoDisposeProvider<bool>.internal(
  anyResonated,
  name: r'anyResonatedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$anyResonatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnyResonatedRef = AutoDisposeProviderRef<bool>;
String _$anyLastWeekHash() => r'04f5862f58616e1490909e7d8c6cb6322702ae22';

/// See also [anyLastWeek].
@ProviderFor(anyLastWeek)
final anyLastWeekProvider = AutoDisposeProvider<bool>.internal(
  anyLastWeek,
  name: r'anyLastWeekProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$anyLastWeekHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnyLastWeekRef = AutoDisposeProviderRef<bool>;
String _$pingViewCountHash() => r'138146ccb8b5c7ee78297a278abab9736a98ec65';

/// See also [pingViewCount].
@ProviderFor(pingViewCount)
const pingViewCountProvider = PingViewCountFamily();

/// See also [pingViewCount].
class PingViewCountFamily extends Family<int> {
  /// See also [pingViewCount].
  const PingViewCountFamily();

  /// See also [pingViewCount].
  PingViewCountProvider call(
    int pingId,
  ) {
    return PingViewCountProvider(
      pingId,
    );
  }

  @override
  PingViewCountProvider getProviderOverride(
    covariant PingViewCountProvider provider,
  ) {
    return call(
      provider.pingId,
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
  String? get name => r'pingViewCountProvider';
}

/// See also [pingViewCount].
class PingViewCountProvider extends AutoDisposeProvider<int> {
  /// See also [pingViewCount].
  PingViewCountProvider(
    int pingId,
  ) : this._internal(
          (ref) => pingViewCount(
            ref as PingViewCountRef,
            pingId,
          ),
          from: pingViewCountProvider,
          name: r'pingViewCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pingViewCountHash,
          dependencies: PingViewCountFamily._dependencies,
          allTransitiveDependencies:
              PingViewCountFamily._allTransitiveDependencies,
          pingId: pingId,
        );

  PingViewCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pingId,
  }) : super.internal();

  final int pingId;

  @override
  Override overrideWith(
    int Function(PingViewCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PingViewCountProvider._internal(
        (ref) => create(ref as PingViewCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pingId: pingId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _PingViewCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PingViewCountProvider && other.pingId == pingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PingViewCountRef on AutoDisposeProviderRef<int> {
  /// The parameter `pingId` of this provider.
  int get pingId;
}

class _PingViewCountProviderElement extends AutoDisposeProviderElement<int>
    with PingViewCountRef {
  _PingViewCountProviderElement(super.provider);

  @override
  int get pingId => (origin as PingViewCountProvider).pingId;
}

String _$pingResonanceCountHash() =>
    r'66a80890d1e458a7a68f542ef9015ff300797744';

/// See also [pingResonanceCount].
@ProviderFor(pingResonanceCount)
const pingResonanceCountProvider = PingResonanceCountFamily();

/// See also [pingResonanceCount].
class PingResonanceCountFamily extends Family<int> {
  /// See also [pingResonanceCount].
  const PingResonanceCountFamily();

  /// See also [pingResonanceCount].
  PingResonanceCountProvider call(
    int pingId,
  ) {
    return PingResonanceCountProvider(
      pingId,
    );
  }

  @override
  PingResonanceCountProvider getProviderOverride(
    covariant PingResonanceCountProvider provider,
  ) {
    return call(
      provider.pingId,
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
  String? get name => r'pingResonanceCountProvider';
}

/// See also [pingResonanceCount].
class PingResonanceCountProvider extends AutoDisposeProvider<int> {
  /// See also [pingResonanceCount].
  PingResonanceCountProvider(
    int pingId,
  ) : this._internal(
          (ref) => pingResonanceCount(
            ref as PingResonanceCountRef,
            pingId,
          ),
          from: pingResonanceCountProvider,
          name: r'pingResonanceCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pingResonanceCountHash,
          dependencies: PingResonanceCountFamily._dependencies,
          allTransitiveDependencies:
              PingResonanceCountFamily._allTransitiveDependencies,
          pingId: pingId,
        );

  PingResonanceCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pingId,
  }) : super.internal();

  final int pingId;

  @override
  Override overrideWith(
    int Function(PingResonanceCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PingResonanceCountProvider._internal(
        (ref) => create(ref as PingResonanceCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pingId: pingId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _PingResonanceCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PingResonanceCountProvider && other.pingId == pingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PingResonanceCountRef on AutoDisposeProviderRef<int> {
  /// The parameter `pingId` of this provider.
  int get pingId;
}

class _PingResonanceCountProviderElement extends AutoDisposeProviderElement<int>
    with PingResonanceCountRef {
  _PingResonanceCountProviderElement(super.provider);

  @override
  int get pingId => (origin as PingResonanceCountProvider).pingId;
}

String _$dayOfWeekFilteredPingsHash() =>
    r'068fb2bedbf220431cbd969477331c110f49ceb7';

/// See also [dayOfWeekFilteredPings].
@ProviderFor(dayOfWeekFilteredPings)
const dayOfWeekFilteredPingsProvider = DayOfWeekFilteredPingsFamily();

/// See also [dayOfWeekFilteredPings].
class DayOfWeekFilteredPingsFamily extends Family<List<PingData>> {
  /// See also [dayOfWeekFilteredPings].
  const DayOfWeekFilteredPingsFamily();

  /// See also [dayOfWeekFilteredPings].
  DayOfWeekFilteredPingsProvider call(
    DayOfWeekEnum dayOfWeek,
  ) {
    return DayOfWeekFilteredPingsProvider(
      dayOfWeek,
    );
  }

  @override
  DayOfWeekFilteredPingsProvider getProviderOverride(
    covariant DayOfWeekFilteredPingsProvider provider,
  ) {
    return call(
      provider.dayOfWeek,
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
  String? get name => r'dayOfWeekFilteredPingsProvider';
}

/// See also [dayOfWeekFilteredPings].
class DayOfWeekFilteredPingsProvider
    extends AutoDisposeProvider<List<PingData>> {
  /// See also [dayOfWeekFilteredPings].
  DayOfWeekFilteredPingsProvider(
    DayOfWeekEnum dayOfWeek,
  ) : this._internal(
          (ref) => dayOfWeekFilteredPings(
            ref as DayOfWeekFilteredPingsRef,
            dayOfWeek,
          ),
          from: dayOfWeekFilteredPingsProvider,
          name: r'dayOfWeekFilteredPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dayOfWeekFilteredPingsHash,
          dependencies: DayOfWeekFilteredPingsFamily._dependencies,
          allTransitiveDependencies:
              DayOfWeekFilteredPingsFamily._allTransitiveDependencies,
          dayOfWeek: dayOfWeek,
        );

  DayOfWeekFilteredPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dayOfWeek,
  }) : super.internal();

  final DayOfWeekEnum dayOfWeek;

  @override
  Override overrideWith(
    List<PingData> Function(DayOfWeekFilteredPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DayOfWeekFilteredPingsProvider._internal(
        (ref) => create(ref as DayOfWeekFilteredPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dayOfWeek: dayOfWeek,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _DayOfWeekFilteredPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DayOfWeekFilteredPingsProvider &&
        other.dayOfWeek == dayOfWeek;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dayOfWeek.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DayOfWeekFilteredPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `dayOfWeek` of this provider.
  DayOfWeekEnum get dayOfWeek;
}

class _DayOfWeekFilteredPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>>
    with DayOfWeekFilteredPingsRef {
  _DayOfWeekFilteredPingsProviderElement(super.provider);

  @override
  DayOfWeekEnum get dayOfWeek =>
      (origin as DayOfWeekFilteredPingsProvider).dayOfWeek;
}

String _$monthFilteredPingsHash() =>
    r'521c57cfc5a748e7a990af1516821bd5490fa357';

/// See also [monthFilteredPings].
@ProviderFor(monthFilteredPings)
const monthFilteredPingsProvider = MonthFilteredPingsFamily();

/// See also [monthFilteredPings].
class MonthFilteredPingsFamily extends Family<List<PingData>> {
  /// See also [monthFilteredPings].
  const MonthFilteredPingsFamily();

  /// See also [monthFilteredPings].
  MonthFilteredPingsProvider call(
    MonthEnum month,
  ) {
    return MonthFilteredPingsProvider(
      month,
    );
  }

  @override
  MonthFilteredPingsProvider getProviderOverride(
    covariant MonthFilteredPingsProvider provider,
  ) {
    return call(
      provider.month,
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
  String? get name => r'monthFilteredPingsProvider';
}

/// See also [monthFilteredPings].
class MonthFilteredPingsProvider extends AutoDisposeProvider<List<PingData>> {
  /// See also [monthFilteredPings].
  MonthFilteredPingsProvider(
    MonthEnum month,
  ) : this._internal(
          (ref) => monthFilteredPings(
            ref as MonthFilteredPingsRef,
            month,
          ),
          from: monthFilteredPingsProvider,
          name: r'monthFilteredPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthFilteredPingsHash,
          dependencies: MonthFilteredPingsFamily._dependencies,
          allTransitiveDependencies:
              MonthFilteredPingsFamily._allTransitiveDependencies,
          month: month,
        );

  MonthFilteredPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
  }) : super.internal();

  final MonthEnum month;

  @override
  Override overrideWith(
    List<PingData> Function(MonthFilteredPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthFilteredPingsProvider._internal(
        (ref) => create(ref as MonthFilteredPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _MonthFilteredPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthFilteredPingsProvider && other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MonthFilteredPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `month` of this provider.
  MonthEnum get month;
}

class _MonthFilteredPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>>
    with MonthFilteredPingsRef {
  _MonthFilteredPingsProviderElement(super.provider);

  @override
  MonthEnum get month => (origin as MonthFilteredPingsProvider).month;
}

String _$dayOfMonthFilteredPingsHash() =>
    r'f59b943ebb953be1ac7158f8999dd93e0fa45dc0';

/// See also [dayOfMonthFilteredPings].
@ProviderFor(dayOfMonthFilteredPings)
const dayOfMonthFilteredPingsProvider = DayOfMonthFilteredPingsFamily();

/// See also [dayOfMonthFilteredPings].
class DayOfMonthFilteredPingsFamily extends Family<List<PingData>> {
  /// See also [dayOfMonthFilteredPings].
  const DayOfMonthFilteredPingsFamily();

  /// See also [dayOfMonthFilteredPings].
  DayOfMonthFilteredPingsProvider call(
    int dayOfMonth,
  ) {
    return DayOfMonthFilteredPingsProvider(
      dayOfMonth,
    );
  }

  @override
  DayOfMonthFilteredPingsProvider getProviderOverride(
    covariant DayOfMonthFilteredPingsProvider provider,
  ) {
    return call(
      provider.dayOfMonth,
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
  String? get name => r'dayOfMonthFilteredPingsProvider';
}

/// See also [dayOfMonthFilteredPings].
class DayOfMonthFilteredPingsProvider
    extends AutoDisposeProvider<List<PingData>> {
  /// See also [dayOfMonthFilteredPings].
  DayOfMonthFilteredPingsProvider(
    int dayOfMonth,
  ) : this._internal(
          (ref) => dayOfMonthFilteredPings(
            ref as DayOfMonthFilteredPingsRef,
            dayOfMonth,
          ),
          from: dayOfMonthFilteredPingsProvider,
          name: r'dayOfMonthFilteredPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dayOfMonthFilteredPingsHash,
          dependencies: DayOfMonthFilteredPingsFamily._dependencies,
          allTransitiveDependencies:
              DayOfMonthFilteredPingsFamily._allTransitiveDependencies,
          dayOfMonth: dayOfMonth,
        );

  DayOfMonthFilteredPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dayOfMonth,
  }) : super.internal();

  final int dayOfMonth;

  @override
  Override overrideWith(
    List<PingData> Function(DayOfMonthFilteredPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DayOfMonthFilteredPingsProvider._internal(
        (ref) => create(ref as DayOfMonthFilteredPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dayOfMonth: dayOfMonth,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _DayOfMonthFilteredPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DayOfMonthFilteredPingsProvider &&
        other.dayOfMonth == dayOfMonth;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dayOfMonth.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DayOfMonthFilteredPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `dayOfMonth` of this provider.
  int get dayOfMonth;
}

class _DayOfMonthFilteredPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>>
    with DayOfMonthFilteredPingsRef {
  _DayOfMonthFilteredPingsProviderElement(super.provider);

  @override
  int get dayOfMonth => (origin as DayOfMonthFilteredPingsProvider).dayOfMonth;
}

String _$yearFilteredPingsHash() => r'17d76b7589eed2721b34f22d566d8a0397c4390f';

/// See also [yearFilteredPings].
@ProviderFor(yearFilteredPings)
const yearFilteredPingsProvider = YearFilteredPingsFamily();

/// See also [yearFilteredPings].
class YearFilteredPingsFamily extends Family<List<PingData>> {
  /// See also [yearFilteredPings].
  const YearFilteredPingsFamily();

  /// See also [yearFilteredPings].
  YearFilteredPingsProvider call(
    int year,
  ) {
    return YearFilteredPingsProvider(
      year,
    );
  }

  @override
  YearFilteredPingsProvider getProviderOverride(
    covariant YearFilteredPingsProvider provider,
  ) {
    return call(
      provider.year,
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
  String? get name => r'yearFilteredPingsProvider';
}

/// See also [yearFilteredPings].
class YearFilteredPingsProvider extends AutoDisposeProvider<List<PingData>> {
  /// See also [yearFilteredPings].
  YearFilteredPingsProvider(
    int year,
  ) : this._internal(
          (ref) => yearFilteredPings(
            ref as YearFilteredPingsRef,
            year,
          ),
          from: yearFilteredPingsProvider,
          name: r'yearFilteredPingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$yearFilteredPingsHash,
          dependencies: YearFilteredPingsFamily._dependencies,
          allTransitiveDependencies:
              YearFilteredPingsFamily._allTransitiveDependencies,
          year: year,
        );

  YearFilteredPingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
  }) : super.internal();

  final int year;

  @override
  Override overrideWith(
    List<PingData> Function(YearFilteredPingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: YearFilteredPingsProvider._internal(
        (ref) => create(ref as YearFilteredPingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PingData>> createElement() {
    return _YearFilteredPingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YearFilteredPingsProvider && other.year == year;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin YearFilteredPingsRef on AutoDisposeProviderRef<List<PingData>> {
  /// The parameter `year` of this provider.
  int get year;
}

class _YearFilteredPingsProviderElement
    extends AutoDisposeProviderElement<List<PingData>>
    with YearFilteredPingsRef {
  _YearFilteredPingsProviderElement(super.provider);

  @override
  int get year => (origin as YearFilteredPingsProvider).year;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
