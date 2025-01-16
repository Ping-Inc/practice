// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_pings_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeModePingsCountHash() =>
    r'a0cec3043775b05f196c7b25be8b59f8fcbdc93c';

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

/// See also [themeModePingsCount].
@ProviderFor(themeModePingsCount)
const themeModePingsCountProvider = ThemeModePingsCountFamily();

/// See also [themeModePingsCount].
class ThemeModePingsCountFamily extends Family<AsyncValue<int>> {
  /// See also [themeModePingsCount].
  const ThemeModePingsCountFamily();

  /// See also [themeModePingsCount].
  ThemeModePingsCountProvider call(
    DateTime time,
  ) {
    return ThemeModePingsCountProvider(
      time,
    );
  }

  @override
  ThemeModePingsCountProvider getProviderOverride(
    covariant ThemeModePingsCountProvider provider,
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
  String? get name => r'themeModePingsCountProvider';
}

/// See also [themeModePingsCount].
class ThemeModePingsCountProvider extends AutoDisposeFutureProvider<int> {
  /// See also [themeModePingsCount].
  ThemeModePingsCountProvider(
    DateTime time,
  ) : this._internal(
          (ref) => themeModePingsCount(
            ref as ThemeModePingsCountRef,
            time,
          ),
          from: themeModePingsCountProvider,
          name: r'themeModePingsCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$themeModePingsCountHash,
          dependencies: ThemeModePingsCountFamily._dependencies,
          allTransitiveDependencies:
              ThemeModePingsCountFamily._allTransitiveDependencies,
          time: time,
        );

  ThemeModePingsCountProvider._internal(
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
  Override overrideWith(
    FutureOr<int> Function(ThemeModePingsCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThemeModePingsCountProvider._internal(
        (ref) => create(ref as ThemeModePingsCountRef),
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
  AutoDisposeFutureProviderElement<int> createElement() {
    return _ThemeModePingsCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeModePingsCountProvider && other.time == time;
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
mixin ThemeModePingsCountRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `time` of this provider.
  DateTime get time;
}

class _ThemeModePingsCountProviderElement
    extends AutoDisposeFutureProviderElement<int> with ThemeModePingsCountRef {
  _ThemeModePingsCountProviderElement(super.provider);

  @override
  DateTime get time => (origin as ThemeModePingsCountProvider).time;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
