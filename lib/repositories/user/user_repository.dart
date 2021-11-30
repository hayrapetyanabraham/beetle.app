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

  // Post: ---------------------------------------------------------------------
  Future<User> getUser() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use

    return await _userApi.getUser().then((user) {
      /* user.posts?.forEach((user) {
        _postDataSource.insert(user);
      });*/

      return user;
    }).catchError((error) => throw error);
  }
}
