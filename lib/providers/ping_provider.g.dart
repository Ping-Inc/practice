// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ping_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pingHash() => r'fee5f6fbdce5754b4b386d34047380de6f84aa7d';

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

abstract class _$Ping extends BuildlessAutoDisposeNotifier<PingData> {
  late final PingData ping;

  PingData build(
    PingData ping,
  );
}

/// See also [Ping].
@ProviderFor(Ping)
const pingProvider = PingFamily();

/// See also [Ping].
class PingFamily extends Family<PingData> {
  /// See also [Ping].
  const PingFamily();

  /// See also [Ping].
  PingProvider call(
    PingData ping,
  ) {
    return PingProvider(
      ping,
    );
  }

  @override
  PingProvider getProviderOverride(
    covariant PingProvider provider,
  ) {
    return call(
      provider.ping,
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
  String? get name => r'pingProvider';
}

/// See also [Ping].
class PingProvider extends AutoDisposeNotifierProviderImpl<Ping, PingData> {
  /// See also [Ping].
  PingProvider(
    PingData ping,
  ) : this._internal(
          () => Ping()..ping = ping,
          from: pingProvider,
          name: r'pingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$pingHash,
          dependencies: PingFamily._dependencies,
          allTransitiveDependencies: PingFamily._allTransitiveDependencies,
          ping: ping,
        );

  PingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ping,
  }) : super.internal();

  final PingData ping;

  @override
  PingData runNotifierBuild(
    covariant Ping notifier,
  ) {
    return notifier.build(
      ping,
    );
  }

  @override
  Override overrideWith(Ping Function() create) {
    return ProviderOverride(
      origin: this,
      override: PingProvider._internal(
        () => create()..ping = ping,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ping: ping,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<Ping, PingData> createElement() {
    return _PingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PingProvider && other.ping == ping;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ping.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PingRef on AutoDisposeNotifierProviderRef<PingData> {
  /// The parameter `ping` of this provider.
  PingData get ping;
}

class _PingProviderElement
    extends AutoDisposeNotifierProviderElement<Ping, PingData> with PingRef {
  _PingProviderElement(super.provider);

  @override
  PingData get ping => (origin as PingProvider).ping;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
