import 'package:app/data/auth/auth_api.dart';
import 'package:app/data/shared/shared_preference_helper.dart';
import 'package:app/models/auth/authorization.dart';

class AuthRepository {
  final AuthApi _authApi;
  final SharedPreferenceHelper _sharedPreferenceHelper;

  AuthRepository(this._authApi, this._sharedPreferenceHelper);

  Future<Authorization> postGetAuth({String email}) async {
    return await _authApi.postGetToken(email: email).then((auth) {
      return auth;
    }).catchError((error) => throw error);
  }

  Future<Authorization> postExtLogin({int providerId, String userToken}) async {
    return await _authApi
        .postExtLogin(providerId: providerId, userToken: userToken)
        .then((auth) {
      return auth;
    }).catchError((error) => throw error);
  }

  Future<void> saveAuthToken({String authToken}) =>
      _sharedPreferenceHelper.saveAuthToken(authToken);

  Future<void> saveRefreshToken({String refreshToken}) =>
      _sharedPreferenceHelper.saveRefreshToken(refreshToken);

  Future<void> saveTokenType({String tokenType}) =>
      _sharedPreferenceHelper.saveTokenType(tokenType);
}
