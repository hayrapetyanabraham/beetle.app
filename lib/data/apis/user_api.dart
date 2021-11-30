import 'package:app/data/network/constants/endpoints.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/models/user/user.dart';

class UserApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  UserApi(this._dioClient);

  /// Returns list of User in response
  Future<User> getUser() async {
    try {
      final res = await _dioClient.get(Endpoints.getUser);
      return User.fromMap(res);
    } catch (e) {
      rethrow;
    }
  }
}
