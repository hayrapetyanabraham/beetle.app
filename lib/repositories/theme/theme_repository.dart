import 'package:app/data/shared/shared_preference_helper.dart';

class ThemeRepository {
  final SharedPreferenceHelper _sharedPrefsHelper;

  ThemeRepository(this._sharedPrefsHelper);

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;
}
