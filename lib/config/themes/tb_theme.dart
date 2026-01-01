import 'package:flutter/material.dart';
import 'package:hoptech_iot_app/utils/transition/page_transitions.dart';

const int _tbPrimaryColorValue = 0xFF37474F;  // Dark grey-blue
const Color _tbPrimaryColor = Color(_tbPrimaryColorValue);
const Color _tbSecondaryColor = Color(0xFF78909C);  // Medium grey-blue  
const Color _tbDarkPrimaryColor = Color(0xFFB0BEC5);  // Light silver-grey
Color get appPrimaryColor => _tbPrimaryColor;
const int _tbTextColorValue = 0xFF212121;  // Dark grey text
const Color _tbTextColor = Color(_tbTextColorValue);

Typography tbTypography = Typography.material2018();

const tbMatIndigo = MaterialColor(_tbPrimaryColorValue, <int, Color>{
  50: Color(0xFFECEFF1),
  100: Color(0xFFCFD8DC),
  200: Color(0xFFB0BEC5),
  300: Color(0xFF90A4AE),
  400: Color(0xFF78909C),
  500: _tbPrimaryColor,
  600: _tbSecondaryColor,
  700: Color(0xFF455A64),
  800: Color(0xFF37474F),
  900: Color(0xFF263238),
});

const tbDarkMatIndigo = MaterialColor(_tbPrimaryColorValue, <int, Color>{
  50: Color(0xFFECEFF1),
  100: Color(0xFFCFD8DC),
  200: Color(0xFFB0BEC5),
  300: Color(0xFF90A4AE),
  400: Color(0xFF78909C),
  500: _tbDarkPrimaryColor,
  600: _tbSecondaryColor,
  700: Color(0xFF455A64),
  800: _tbPrimaryColor,
  900: Color(0xFF263238),
});

final ThemeData theme = ThemeData(primarySwatch: tbMatIndigo);

ThemeData tbTheme = ThemeData(
  useMaterial3: false,
  primarySwatch: tbMatIndigo,
  colorScheme: theme.colorScheme.copyWith(
    primary: tbMatIndigo,
    secondary: Colors.deepOrange,
  ),
  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
  textTheme: tbTypography.black,
  primaryTextTheme: tbTypography.black,
  typography: tbTypography,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: _tbTextColor,
    iconTheme: IconThemeData(color: _tbTextColor),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: _tbPrimaryColor,
    unselectedItemColor: Colors.black.withValues(alpha: .38),
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: FadeOpenPageTransitionsBuilder(),
      TargetPlatform.android: FadeOpenPageTransitionsBuilder(),
    },
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: tbDarkMatIndigo,
  brightness: Brightness.dark,
);

ThemeData tbDarkTheme = ThemeData(
  primarySwatch: tbDarkMatIndigo,
  colorScheme: darkTheme.colorScheme.copyWith(secondary: Colors.deepOrange),
  brightness: Brightness.dark,
);
