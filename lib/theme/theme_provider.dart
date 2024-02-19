import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/utils/shared_utility.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  final themeMode = SharedUtility().themeMode();
  return ThemeNotifier(defaultThemeMode: themeMode);
});

class ThemeNotifier extends StateNotifier<bool> {
  final bool defaultThemeMode;
  ThemeNotifier({required this.defaultThemeMode}) : super(defaultThemeMode);
  void toogleTheme() {
    state = !state;
    SharedUtility().setThemeMode(state);
  }
}
