import 'dart:async';

import 'package:app/data/shared/constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<void> saveAuthToken(String authToken) async {
    _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

//refreshToken
  Future<String> get refreshToken async {
    return _sharedPreference.getString(Preferences.refreshToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    _sharedPreference.setString(Preferences.refreshToken, refreshToken);
  }

  Future<bool> removeRefreshToken() async {
    return _sharedPreference.remove(Preferences.refreshToken);
  }

  //tokenType
  Future<String> get tokenType async {
    return _sharedPreference.getString(Preferences.tokenType);
  }

  Future<void> saveTokenType(String tokenType) async {
    _sharedPreference.setString(Preferences.tokenType, tokenType);
  }

  Future<bool> removeTokenType() async {
    return _sharedPreference.remove(Preferences.tokenType);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }
}
