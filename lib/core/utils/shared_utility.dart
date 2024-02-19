import 'package:shared_preferences/shared_preferences.dart';

class SharedUtility {
  static SharedUtility? _instance;
  static SharedPreferences? _prefs;

  factory SharedUtility() {
    if (_instance == null) {
      throw ("Please ensure sharedUtility is initialize.");
    } else {
      return _instance!;
    }
  }

  //private constructor
  const SharedUtility._();

  static ensureInitalize() async {
    _prefs ??= await SharedPreferences.getInstance();
    _instance ??= const SharedUtility._();
  }

  static const _themeKey = 'theme';

  bool themeMode() {
    final themeValue = _prefs!.getBool(_themeKey);
    if (themeValue == null) return false;
    return themeValue;
  }
  Future<void> setThemeMode(bool themeValue) async {
    await _prefs!.setBool(_themeKey, themeValue);
  }
}
