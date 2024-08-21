import 'package:app/data/shared/shared_preference_helper.dart';

class LanguageRepository {
  final SharedPreferenceHelper _sharedPrefsHelper;

  LanguageRepository(this._sharedPrefsHelper);

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
