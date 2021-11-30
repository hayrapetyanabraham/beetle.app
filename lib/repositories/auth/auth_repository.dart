import 'package:app/data/auth/auth_api.dart';
import 'package:app/data/shared/shared_preference_helper.dart';
import 'package:app/models/auth/authorization.dart';

class AuthRepository {
  final AuthApi _authApi;
  final SharedPreferenceHelper _sharedPreferenceHelper;

  AuthRepository(this._authApi, this._sharedPreferenceHelper);

  Future<Authorization> postGetAuth({String? email}) async {
/*    return await _authApi.postGetToken({String email}){


    }*/

    return await _authApi.postGetToken(email: email).then((auth) {
      /* user.posts?.forEach((user) {
        _postDataSource.insert(user);
      });*/

      return auth;
    }).catchError((error) => throw error);
  }
}
