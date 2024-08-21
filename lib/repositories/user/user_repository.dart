import 'package:app/data/apis/user_api.dart';
import 'package:app/data/shared/shared_preference_helper.dart';
import 'package:app/models/user/user.dart';

class UserRepository {
  // api objects
  final UserApi _userApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserRepository(this._userApi, this._sharedPrefsHelper);

  Future<User> getUser() async {
    return await _userApi.getUser().then((user) {
      return user;
    }).catchError((error) => throw error);
  }
}
