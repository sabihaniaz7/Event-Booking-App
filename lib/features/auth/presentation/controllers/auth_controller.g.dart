// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the current user (or null). This is what go_router watches
/// to decide whether to redirect to /login.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// Holds the current user (or null). This is what go_router watches
/// to decide whether to redirect to /login.
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, UserEntity?> {
  /// Holds the current user (or null). This is what go_router watches
  /// to decide whether to redirect to /login.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'dfc726880e05644c44211f665213953c8cee2430';

/// Holds the current user (or null). This is what go_router watches
/// to decide whether to redirect to /login.

abstract class _$AuthController extends $AsyncNotifier<UserEntity?> {
  FutureOr<UserEntity?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserEntity?>, UserEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserEntity?>, UserEntity?>,
              AsyncValue<UserEntity?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
