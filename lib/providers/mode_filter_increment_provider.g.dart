// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mode_filter_increment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$modeFilterIncrementHash() =>
    r'8eb980a82f8a30b987a94a0ae54a2a3d81cfa316';

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

abstract class _$ModeFilterIncrement
    extends BuildlessAutoDisposeNotifier<ThemeModeEnum> {
  late final DateTime time;

  ThemeModeEnum build(
    DateTime time,
  );
}

/// See also [ModeFilterIncrement].
@ProviderFor(ModeFilterIncrement)
const modeFilterIncrementProvider = ModeFilterIncrementFamily();

/// See also [ModeFilterIncrement].
class ModeFilterIncrementFamily extends Family<ThemeModeEnum> {
  /// See also [ModeFilterIncrement].
  const ModeFilterIncrementFamily();

  /// See also [ModeFilterIncrement].
  ModeFilterIncrementProvider call(
    DateTime time,
  ) {
    return ModeFilterIncrementProvider(
      time,
    );
  }

  @override
  ModeFilterIncrementProvider getProviderOverride(
    covariant ModeFilterIncrementProvider provider,
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
  String? get name => r'modeFilterIncrementProvider';
}

/// See also [ModeFilterIncrement].
class ModeFilterIncrementProvider extends AutoDisposeNotifierProviderImpl<
    ModeFilterIncrement, ThemeModeEnum> {
  /// See also [ModeFilterIncrement].
  ModeFilterIncrementProvider(
    DateTime time,
  ) : this._internal(
          () => ModeFilterIncrement()..time = time,
          from: modeFilterIncrementProvider,
          name: r'modeFilterIncrementProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$modeFilterIncrementHash,
          dependencies: ModeFilterIncrementFamily._dependencies,
          allTransitiveDependencies:
              ModeFilterIncrementFamily._allTransitiveDependencies,
          time: time,
        );

  ModeFilterIncrementProvider._internal(
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
  ThemeModeEnum runNotifierBuild(
    covariant ModeFilterIncrement notifier,
  ) {
    return notifier.build(
      time,
    );
  }

  @override
  Override overrideWith(ModeFilterIncrement Function() create) {
    return ProviderOverride(
      origin: this,
      override: ModeFilterIncrementProvider._internal(
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
  AutoDisposeNotifierProviderElement<ModeFilterIncrement, ThemeModeEnum>
      createElement() {
    return _ModeFilterIncrementProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ModeFilterIncrementProvider && other.time == time;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, time.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ModeFilterIncrementRef on AutoDisposeNotifierProviderRef<ThemeModeEnum> {
  /// The parameter `time` of this provider.
  DateTime get time;
}

class _ModeFilterIncrementProviderElement
    extends AutoDisposeNotifierProviderElement<ModeFilterIncrement,
        ThemeModeEnum> with ModeFilterIncrementRef {
  _ModeFilterIncrementProviderElement(super.provider);

  @override
  DateTime get time => (origin as ModeFilterIncrementProvider).time;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
