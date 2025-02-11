// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replies_to_ping_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$repliesToPingCountHash() =>
    r'505df4a892c74056fce4c3b7b86536b7534adf4d';

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

/// See also [repliesToPingCount].
@ProviderFor(repliesToPingCount)
const repliesToPingCountProvider = RepliesToPingCountFamily();

/// See also [repliesToPingCount].
class RepliesToPingCountFamily extends Family<AsyncValue<int>> {
  /// See also [repliesToPingCount].
  const RepliesToPingCountFamily();

  /// See also [repliesToPingCount].
  RepliesToPingCountProvider call(
    int id,
  ) {
    return RepliesToPingCountProvider(
      id,
    );
  }

  @override
  RepliesToPingCountProvider getProviderOverride(
    covariant RepliesToPingCountProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'repliesToPingCountProvider';
}

/// See also [repliesToPingCount].
class RepliesToPingCountProvider extends AutoDisposeFutureProvider<int> {
  /// See also [repliesToPingCount].
  RepliesToPingCountProvider(
    int id,
  ) : this._internal(
          (ref) => repliesToPingCount(
            ref as RepliesToPingCountRef,
            id,
          ),
          from: repliesToPingCountProvider,
          name: r'repliesToPingCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repliesToPingCountHash,
          dependencies: RepliesToPingCountFamily._dependencies,
          allTransitiveDependencies:
              RepliesToPingCountFamily._allTransitiveDependencies,
          id: id,
        );

  RepliesToPingCountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<int> Function(RepliesToPingCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RepliesToPingCountProvider._internal(
        (ref) => create(ref as RepliesToPingCountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _RepliesToPingCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RepliesToPingCountProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RepliesToPingCountRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `id` of this provider.
  int get id;
}

class _RepliesToPingCountProviderElement
    extends AutoDisposeFutureProviderElement<int> with RepliesToPingCountRef {
  _RepliesToPingCountProviderElement(super.provider);

  @override
  int get id => (origin as RepliesToPingCountProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
