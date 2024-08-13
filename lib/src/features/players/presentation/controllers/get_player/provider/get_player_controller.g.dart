// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_player_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPlayerControllerHash() =>
    r'c80ba5b4758cfc6a8aea15acca1c55362592ce2c';

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

abstract class _$GetPlayerController
    extends BuildlessAutoDisposeAsyncNotifier<GetPlayerControllerState> {
  late final int playerId;

  Future<GetPlayerControllerState> build({
    required int playerId,
  });
}

/// See also [GetPlayerController].
@ProviderFor(GetPlayerController)
const getPlayerControllerProvider = GetPlayerControllerFamily();

/// See also [GetPlayerController].
class GetPlayerControllerFamily
    extends Family<AsyncValue<GetPlayerControllerState>> {
  /// See also [GetPlayerController].
  const GetPlayerControllerFamily();

  /// See also [GetPlayerController].
  GetPlayerControllerProvider call({
    required int playerId,
  }) {
    return GetPlayerControllerProvider(
      playerId: playerId,
    );
  }

  @override
  GetPlayerControllerProvider getProviderOverride(
    covariant GetPlayerControllerProvider provider,
  ) {
    return call(
      playerId: provider.playerId,
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
  String? get name => r'getPlayerControllerProvider';
}

/// See also [GetPlayerController].
class GetPlayerControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetPlayerController, GetPlayerControllerState> {
  /// See also [GetPlayerController].
  GetPlayerControllerProvider({
    required int playerId,
  }) : this._internal(
          () => GetPlayerController()..playerId = playerId,
          from: getPlayerControllerProvider,
          name: r'getPlayerControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPlayerControllerHash,
          dependencies: GetPlayerControllerFamily._dependencies,
          allTransitiveDependencies:
              GetPlayerControllerFamily._allTransitiveDependencies,
          playerId: playerId,
        );

  GetPlayerControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.playerId,
  }) : super.internal();

  final int playerId;

  @override
  Future<GetPlayerControllerState> runNotifierBuild(
    covariant GetPlayerController notifier,
  ) {
    return notifier.build(
      playerId: playerId,
    );
  }

  @override
  Override overrideWith(GetPlayerController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPlayerControllerProvider._internal(
        () => create()..playerId = playerId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        playerId: playerId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetPlayerController,
      GetPlayerControllerState> createElement() {
    return _GetPlayerControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPlayerControllerProvider && other.playerId == playerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, playerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPlayerControllerRef
    on AutoDisposeAsyncNotifierProviderRef<GetPlayerControllerState> {
  /// The parameter `playerId` of this provider.
  int get playerId;
}

class _GetPlayerControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPlayerController,
        GetPlayerControllerState> with GetPlayerControllerRef {
  _GetPlayerControllerProviderElement(super.provider);

  @override
  int get playerId => (origin as GetPlayerControllerProvider).playerId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
