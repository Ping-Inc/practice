// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_replies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pingRepliesHash() => r'3d7effa65aa0159cae22a9d8d967a966160cc332';

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

abstract class _$PingReplies
    extends BuildlessAutoDisposeAsyncNotifier<List<PingData>> {
  late final int id;

  FutureOr<List<PingData>> build(
    int id,
  );
}

/// See also [PingReplies].
@ProviderFor(PingReplies)
const pingRepliesProvider = PingRepliesFamily();

/// See also [PingReplies].
class PingRepliesFamily extends Family<AsyncValue<List<PingData>>> {
  /// See also [PingReplies].
  const PingRepliesFamily();

  /// See also [PingReplies].
  PingRepliesProvider call(
    int id,
  ) {
    return PingRepliesProvider(
      id,
    );
  }

  @override
  PingRepliesProvider getProviderOverride(
    covariant PingRepliesProvider provider,
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
  String? get name => r'pingRepliesProvider';
}

/// See also [PingReplies].
class PingRepliesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PingReplies, List<PingData>> {
  /// See also [PingReplies].
  PingRepliesProvider(
    int id,
  ) : this._internal(
          () => PingReplies()..id = id,
          from: pingRepliesProvider,
          name: r'pingRepliesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pingRepliesHash,
          dependencies: PingRepliesFamily._dependencies,
          allTransitiveDependencies:
              PingRepliesFamily._allTransitiveDependencies,
          id: id,
        );

  PingRepliesProvider._internal(
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
  FutureOr<List<PingData>> runNotifierBuild(
    covariant PingReplies notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PingReplies Function() create) {
    return ProviderOverride(
      origin: this,
      override: PingRepliesProvider._internal(
        () => create()..id = id,
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
  AutoDisposeAsyncNotifierProviderElement<PingReplies, List<PingData>>
      createElement() {
    return _PingRepliesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PingRepliesProvider && other.id == id;
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
mixin PingRepliesRef on AutoDisposeAsyncNotifierProviderRef<List<PingData>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PingRepliesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PingReplies, List<PingData>>
    with PingRepliesRef {
  _PingRepliesProviderElement(super.provider);

  @override
  int get id => (origin as PingRepliesProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
