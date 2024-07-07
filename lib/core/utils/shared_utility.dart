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
  static const _initScreen = 'initscreen';
  static const _rememberMe = 'rememberMe';
  static const _userEmail = 'userEmail';

  bool themeMode() {
    final themeValue = _prefs!.getBool(_themeKey);
    if (themeValue == null) return false;
    return themeValue;
  }

  Future<void> setThemeMode(bool themeValue) async {
    await _prefs!.setBool(_themeKey, themeValue);
  }

  bool getOnBoarding() {
    final isFirst = _prefs!.getBool(_initScreen);
    if (isFirst == null) return false;
    return isFirst;
  }

  Future<void> setOnBoarding() async {
    await _prefs!.setBool(_initScreen, true);
  }

  bool rememberMe() {
    final remember = _prefs!.getBool(_rememberMe);
    if (remember == null) return false;
    return remember;
  }

  Future<void> setRemeberMe(bool value) async {
    await _prefs!.setBool(_rememberMe, value);
  }

  String? getEmail() {
    final email = _prefs!.getString(_userEmail);
    return email;
  }

  Future<void> setEmail(String email) async {
    await _prefs!.setString(_userEmail, email);
  }
}
