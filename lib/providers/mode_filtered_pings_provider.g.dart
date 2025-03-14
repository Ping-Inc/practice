// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mode_filtered_pings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$modeFilteredPingsHash() => r'aad6f7fa4b94573fb6c0ffd588f9b0c784ec2f37';

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

abstract class _$ModeFilteredPings
    extends BuildlessAutoDisposeAsyncNotifier<List<PingData>> {
  late final ThemeModeEnum mode;

  FutureOr<List<PingData>> build(
    ThemeModeEnum mode,
  );
}

/// See also [ModeFilteredPings].
@ProviderFor(ModeFilteredPings)
const modeFilteredPingsProvider = ModeFilteredPingsFamily();

/// See also [ModeFilteredPings].
class ModeFilteredPingsFamily extends Family<AsyncValue<List<PingData>>> {
  /// See also [ModeFilteredPings].
  const ModeFilteredPingsFamily();

  /// See also [ModeFilteredPings].
  ModeFilteredPingsProvider call(
    ThemeModeEnum mode,
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

/// See also [ModeFilteredPings].
class ModeFilteredPingsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ModeFilteredPings, List<PingData>> {
  /// See also [ModeFilteredPings].
  ModeFilteredPingsProvider(
    ThemeModeEnum mode,
  ) : this._internal(
          () => ModeFilteredPings()..mode = mode,
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

  final ThemeModeEnum mode;

  @override
  FutureOr<List<PingData>> runNotifierBuild(
    covariant ModeFilteredPings notifier,
  ) {
    return notifier.build(
      mode,
    );
  }

  @override
  Override overrideWith(ModeFilteredPings Function() create) {
    return ProviderOverride(
      origin: this,
      override: ModeFilteredPingsProvider._internal(
        () => create()..mode = mode,
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
  AutoDisposeAsyncNotifierProviderElement<ModeFilteredPings, List<PingData>>
      createElement() {
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
mixin ModeFilteredPingsRef
    on AutoDisposeAsyncNotifierProviderRef<List<PingData>> {
  /// The parameter `mode` of this provider.
  ThemeModeEnum get mode;
}

class _ModeFilteredPingsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ModeFilteredPings,
        List<PingData>> with ModeFilteredPingsRef {
  _ModeFilteredPingsProviderElement(super.provider);

  @override
  ThemeModeEnum get mode => (origin as ModeFilteredPingsProvider).mode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
