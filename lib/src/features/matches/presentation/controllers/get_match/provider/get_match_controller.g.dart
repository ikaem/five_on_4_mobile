// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_match_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMatchControllerHash() =>
    r'079aff4a3cf2100ca72d4d46ee4ac7a801e9ed36';

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

abstract class _$GetMatchController
    extends BuildlessAutoDisposeAsyncNotifier<MatchControllerState> {
  late final int matchId;

  Future<MatchControllerState> build({
    required int matchId,
  });
}

/// See also [GetMatchController].
@ProviderFor(GetMatchController)
const getMatchControllerProvider = GetMatchControllerFamily();

/// See also [GetMatchController].
class GetMatchControllerFamily
    extends Family<AsyncValue<MatchControllerState>> {
  /// See also [GetMatchController].
  const GetMatchControllerFamily();

  /// See also [GetMatchController].
  GetMatchControllerProvider call({
    required int matchId,
  }) {
    return GetMatchControllerProvider(
      matchId: matchId,
    );
  }

  @override
  GetMatchControllerProvider getProviderOverride(
    covariant GetMatchControllerProvider provider,
  ) {
    return call(
      matchId: provider.matchId,
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
  String? get name => r'getMatchControllerProvider';
}

/// See also [GetMatchController].
class GetMatchControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetMatchController, MatchControllerState> {
  /// See also [GetMatchController].
  GetMatchControllerProvider({
    required int matchId,
  }) : this._internal(
          () => GetMatchController()..matchId = matchId,
          from: getMatchControllerProvider,
          name: r'getMatchControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMatchControllerHash,
          dependencies: GetMatchControllerFamily._dependencies,
          allTransitiveDependencies:
              GetMatchControllerFamily._allTransitiveDependencies,
          matchId: matchId,
        );

  GetMatchControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.matchId,
  }) : super.internal();

  final int matchId;

  @override
  Future<MatchControllerState> runNotifierBuild(
    covariant GetMatchController notifier,
  ) {
    return notifier.build(
      matchId: matchId,
    );
  }

  @override
  Override overrideWith(GetMatchController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetMatchControllerProvider._internal(
        () => create()..matchId = matchId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        matchId: matchId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetMatchController,
      MatchControllerState> createElement() {
    return _GetMatchControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMatchControllerProvider && other.matchId == matchId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, matchId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMatchControllerRef
    on AutoDisposeAsyncNotifierProviderRef<MatchControllerState> {
  /// The parameter `matchId` of this provider.
  int get matchId;
}

class _GetMatchControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetMatchController,
        MatchControllerState> with GetMatchControllerRef {
  _GetMatchControllerProviderElement(super.provider);

  @override
  int get matchId => (origin as GetMatchControllerProvider).matchId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
