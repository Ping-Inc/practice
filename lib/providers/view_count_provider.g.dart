// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$viewCountHash() => r'eced586f7fa992cb558dedf3ebbc356bc5fc82ed';

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

abstract class _$ViewCount extends BuildlessAutoDisposeAsyncNotifier<int> {
  late final int pingId;

  FutureOr<int> build(
    int pingId,
  );
}

/// See also [ViewCount].
@ProviderFor(ViewCount)
const viewCountProvider = ViewCountFamily();

/// See also [ViewCount].
class ViewCountFamily extends Family<AsyncValue<int>> {
  /// See also [ViewCount].
  const ViewCountFamily();

  /// See also [ViewCount].
  ViewCountProvider call(
    int pingId,
  ) {
    return ViewCountProvider(
      pingId,
    );
  }

  @override
  ViewCountProvider getProviderOverride(
    covariant ViewCountProvider provider,
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
  String? get name => r'viewCountProvider';
}

/// See also [ViewCount].
class ViewCountProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ViewCount, int> {
  /// See also [ViewCount].
  ViewCountProvider(
    int pingId,
  ) : this._internal(
          () => ViewCount()..pingId = pingId,
          from: viewCountProvider,
          name: r'viewCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$viewCountHash,
          dependencies: ViewCountFamily._dependencies,
          allTransitiveDependencies: ViewCountFamily._allTransitiveDependencies,
          pingId: pingId,
        );

  ViewCountProvider._internal(
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
  FutureOr<int> runNotifierBuild(
    covariant ViewCount notifier,
  ) {
    return notifier.build(
      pingId,
    );
  }

  @override
  Override overrideWith(ViewCount Function() create) {
    return ProviderOverride(
      origin: this,
      override: ViewCountProvider._internal(
        () => create()..pingId = pingId,
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
  AutoDisposeAsyncNotifierProviderElement<ViewCount, int> createElement() {
    return _ViewCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ViewCountProvider && other.pingId == pingId;
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
mixin ViewCountRef on AutoDisposeAsyncNotifierProviderRef<int> {
  /// The parameter `pingId` of this provider.
  int get pingId;
}

class _ViewCountProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ViewCount, int>
    with ViewCountRef {
  _ViewCountProviderElement(super.provider);

  @override
  int get pingId => (origin as ViewCountProvider).pingId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
