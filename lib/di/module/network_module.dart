import 'dart:io';

import 'package:app/data/network/constants/endpoints.dart';
import 'package:app/data/shared/shared_preference_helper.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.

  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            // getting token
            String deviceName = '';
            String deviceVersion = '';
            String identifier = '';
            String platform = '';
            var token = await sharedPrefHelper.authToken;
            final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
            if (Platform.isAndroid) {
              var build = await deviceInfoPlugin.androidInfo;
              deviceName = build.model;
              deviceVersion = build.version.release;
              identifier = build.androidId;
              platform = 'android';

              //UUID for Android
            } else if (Platform.isIOS) {
              var data = await deviceInfoPlugin.iosInfo;
              deviceName = data.name;
              deviceVersion = data.systemVersion;
              identifier = data.identifierForVendor;
              platform = 'iOS';
            }
            options.headers.putIfAbsent('X-Device-Platform', () => platform);
            options.headers.putIfAbsent('X-DeviceId', () => identifier);
            options.headers
                .putIfAbsent('X-Device-Version', () => deviceVersion);
            options.headers.putIfAbsent('X-Device-Model', () => deviceName);

            if (kDebugMode) {
              print(
                  'X-Device-Platform: $platform  X-DeviceId: $identifier  X-Device-Version: $deviceVersion  X-Device-Model: $deviceName');
            }

            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => token);
            } else {
              print('Auth token is null');
            }

            return handler.next(options);
          },
        ),
      );

    return dio;
  }
}
