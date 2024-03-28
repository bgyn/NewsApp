import 'package:flutter/material.dart';

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;
const primaryColor = Color.fromRGBO(24, 119, 242, 1);

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        color1: isDarkTheme ? Colors.blue : Colors.blue,
        color2: const Color.fromARGB(255, 161, 161, 161),
        color3: isDarkTheme ? Colors.white : Colors.black,
        color4:
            isDarkTheme ? const Color.fromARGB(255, 87, 87, 87) : Colors.white,
      )
    ],
    scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
    primaryColor: const Color.fromRGBO(24, 119, 242, 1),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(foregroundColor: Colors.blue),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      labelMedium: const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
    ),
  );
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final Color? color4;

  const AppColors({
    required this.color1,
    required this.color2,
    required this.color3,
    required this.color4,
  });

  @override
  AppColors copyWith({
    Color? color1,
    Color? color2,
    Color? color3,
    Color? color4,
  }) {
    return AppColors(
        color1: color1 ?? this.color1,
        color2: color2 ?? this.color2,
        color3: color3 ?? this.color3,
        color4: color4 ?? this.color4);
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      color1: Color.lerp(color1, other.color1, t),
      color2: Color.lerp(color2, other.color2, t),
      color3: Color.lerp(color3, other.color3, t),
      color4: Color.lerp(color4, other.color4, t),
    );
  }
}
