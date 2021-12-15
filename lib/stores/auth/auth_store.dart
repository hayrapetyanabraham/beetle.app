import 'package:app/error/dio_error_util.dart';
import 'package:app/models/auth/authorization.dart';
import 'package:app/repositories/auth/auth_repository.dart';
import 'package:app/stores/error/error_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthErrorStore authErrorStore = AuthErrorStore();
  late AuthRepository _repository;
  late List<ReactionDisposer> _disposers;
  final ErrorStore errorStore = ErrorStore();

  _AuthStore(AuthRepository repository) {
    _repository = repository;
    _setupValidations();
  }

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword)
    ];
  }

  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  String userToken = '';

  @observable
  int? providerId;

  @observable
  String confirmPassword = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool isAgreeConditions = false;

  @observable
  Map<String, dynamic>? _userData;

  @computed
  bool get canLogin => !authErrorStore.hasErrorsInLogin && userEmail.isNotEmpty;

  @computed
  bool get isReadyToLogin =>
      authErrorStore.userEmail == null &&
      userEmail.isNotEmpty &&
      isAgreeConditions;

  //&& password.isNotEmpty;

  @computed
  bool get canRegister =>
      !authErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !authErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  static ObservableFuture<Authorization?> authorizationResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Authorization?> fetchAuthorizationFuture =
      ObservableFuture<Authorization?>(authorizationResponse);

  @observable
  Authorization? authorization;

  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      authErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      authErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      authErrorStore.userEmail = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      authErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      authErrorStore.password = "Password must be at-least 6 characters long";
    } else {
      authErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      authErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      authErrorStore.confirmPassword = "Password doen't match";
    } else {
      authErrorStore.confirmPassword = null;
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        return googleAuth.idToken;
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('message is ${e.message}');
        print('code is ${e.code}');
        print('details is ${e.details}');
      }
      var errorCode = "Google Sign In Error";
      switch (e.message) {
        case "sign_in_canceled":
          {
            errorCode = "Sign In Canceled";
          }
          break;
      }
      return errorCode;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signInWithFacebook() async {
    final LoginResult result =
        await FacebookAuth.instance.login(permissions: ['email']);

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();

      _userData = userData;
    } else {
      print(result.message);
    }
    return result.accessToken!.token;
  }

  @action
  Future postExtLogin() async {
    loading = true;
    final future =
        _repository.postExtLogin(userToken: userToken, providerId: providerId);
    fetchAuthorizationFuture = ObservableFuture(future);
    future.then((authorization) {
      this.authorization = authorization;
      loading = false;
      success = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      loading = false;
      success = false;
    });
  }

  @action
  Future register() async {
    loading = true;
    final future = _repository.postGetAuth(email: userEmail);
    fetchAuthorizationFuture = ObservableFuture(future);
    future.then((authorization) {
      this.authorization = authorization;
      loading = false;
      success = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      loading = false;
      success = false;
    });
  }

  @action
  Future login() async {
    loading = true;

    Future.delayed(const Duration(milliseconds: 2000)).then((future) {
      loading = false;
      success = true;
    }).catchError((e) {
      loading = false;
      success = false;
      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    loading = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
  }
}

class AuthErrorStore = _AuthErrorStore with _$AuthErrorStore;

abstract class _AuthErrorStore with Store {
  @observable
  String? userEmail;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null || password != null || confirmPassword != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;
}
