// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_AuthStore.canLogin'))
      .value;
  Computed<bool>? _$isReadyToLoginComputed;

  @override
  bool get isReadyToLogin =>
      (_$isReadyToLoginComputed ??= Computed<bool>(() => super.isReadyToLogin,
              name: '_AuthStore.isReadyToLogin'))
          .value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_AuthStore.canRegister'))
          .value;
  Computed<bool>? _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_AuthStore.canForgetPassword'))
      .value;

  final _$userEmailAtom = Atom(name: '_AuthStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$passwordAtom = Atom(name: '_AuthStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$userTokenAtom = Atom(name: '_AuthStore.userToken');

  @override
  String get userToken {
    _$userTokenAtom.reportRead();
    return super.userToken;
  }

  @override
  set userToken(String value) {
    _$userTokenAtom.reportWrite(value, super.userToken, () {
      super.userToken = value;
    });
  }

  final _$providerIdAtom = Atom(name: '_AuthStore.providerId');

  @override
  int? get providerId {
    _$providerIdAtom.reportRead();
    return super.providerId;
  }

  @override
  set providerId(int? value) {
    _$providerIdAtom.reportWrite(value, super.providerId, () {
      super.providerId = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_AuthStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
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

  final _$loadingAtom = Atom(name: '_AuthStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$isAgreeConditionsAtom = Atom(name: '_AuthStore.isAgreeConditions');

  @override
  bool get isAgreeConditions {
    _$isAgreeConditionsAtom.reportRead();
    return super.isAgreeConditions;
  }

  @override
  set isAgreeConditions(bool value) {
    _$isAgreeConditionsAtom.reportWrite(value, super.isAgreeConditions, () {
      super.isAgreeConditions = value;
    });
  }

  final _$_userDataAtom = Atom(name: '_AuthStore._userData');

  @override
  Map<String, dynamic>? get _userData {
    _$_userDataAtom.reportRead();
    return super._userData;
  }

  @override
  set _userData(Map<String, dynamic>? value) {
    _$_userDataAtom.reportWrite(value, super._userData, () {
      super._userData = value;
    });
  }

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

  final _$postExtLoginAsyncAction = AsyncAction('_AuthStore.postExtLogin');

  @override
  Future<dynamic> postExtLogin() {
    return _$postExtLoginAsyncAction.run(() => super.postExtLogin());
  }

  final _$registerAsyncAction = AsyncAction('_AuthStore.register');

  @override
  Future<dynamic> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  final _$loginAsyncAction = AsyncAction('_AuthStore.login');

  @override
  Future<dynamic> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$forgotPasswordAsyncAction = AsyncAction('_AuthStore.forgotPassword');

  @override
  Future<dynamic> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
  }

  final _$logoutAsyncAction = AsyncAction('_AuthStore.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void setUserId(String value) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
password: ${password},
userToken: ${userToken},
providerId: ${providerId},
confirmPassword: ${confirmPassword},
success: ${success},
loading: ${loading},
isAgreeConditions: ${isAgreeConditions},
fetchAuthorizationFuture: ${fetchAuthorizationFuture},
authorization: ${authorization},
canLogin: ${canLogin},
isReadyToLogin: ${isReadyToLogin},
canRegister: ${canRegister},
canForgetPassword: ${canForgetPassword}
    ''';
  }
}

mixin _$AuthErrorStore on _AuthErrorStore, Store {
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_AuthErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_AuthErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool>? _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_AuthErrorStore.hasErrorInForgotPassword'))
      .value;

  final _$userEmailAtom = Atom(name: '_AuthErrorStore.userEmail');

  @override
  String? get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String? value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$passwordAtom = Atom(name: '_AuthErrorStore.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_AuthErrorStore.confirmPassword');

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
password: ${password},
confirmPassword: ${confirmPassword},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword}
    ''';
  }
}
