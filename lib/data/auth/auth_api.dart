import 'package:app/data/network/constants/endpoints.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/models/auth/authorization.dart';
import 'package:dio/dio.dart';

class AuthApi {
  final DioClient _dioClient;

  AuthApi(this._dioClient);

  Future<Authorization> postGetToken({String email}) async {
    try {
      var map = <String, dynamic>{};
      map['email'] = email;
      final res = await _dioClient.post(Endpoints.postGetToken, data: map);
      return Authorization.fromMap(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<Authorization> postExtLogin({int providerId, String userToken}) async {
    try {
      /* var map = <String, dynamic>{};
      map['ProviderId'] = providerId;
      map['UserToken'] = userToken;*/

      var formData = FormData.fromMap({
        'ProviderId': providerId,
        'UserToken': userToken,
      });

      print(formData);

      final res = await _dioClient.post(Endpoints.postExtLogin, data: formData);
      print(res);
      return Authorization.fromMap(res);
    } catch (e) {
      rethrow;
    }
  }
}
