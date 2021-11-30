// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_AuthStore.loading'))
      .value;

  final _$fetchAuthorizationFutureAtom =
      Atom(name: '_AuthStore.fetchAuthorizationFuture');

  @override
  ObservableFuture<Authorization?> get fetchAuthorizationFuture {
    _$fetchAuthorizationFutureAtom.reportRead();
    return super.fetchAuthorizationFuture;
  }

  @override
  set fetchAuthorizationFuture(ObservableFuture<Authorization?> value) {
    _$fetchAuthorizationFutureAtom
        .reportWrite(value, super.fetchAuthorizationFuture, () {
      super.fetchAuthorizationFuture = value;
    });
  }

  final _$authorizationAtom = Atom(name: '_AuthStore.authorization');

  @override
  Authorization? get authorization {
    _$authorizationAtom.reportRead();
    return super.authorization;
  }

  @override
  set authorization(Authorization? value) {
    _$authorizationAtom.reportWrite(value, super.authorization, () {
      super.authorization = value;
    });
  }

  final _$successAtom = Atom(name: '_AuthStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$emailAtom = Atom(name: '_AuthStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$postGetAuthAsyncAction = AsyncAction('_AuthStore.postGetAuth');

  @override
  Future<dynamic> postGetAuth() {
    return _$postGetAuthAsyncAction.run(() => super.postGetAuth());
  }

  @override
  String toString() {
    return '''
fetchAuthorizationFuture: ${fetchAuthorizationFuture},
authorization: ${authorization},
success: ${success},
email: ${email},
loading: ${loading}
    ''';
  }
}
