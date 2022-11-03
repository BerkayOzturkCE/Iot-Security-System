import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant {
  // Colors
  static final Color colorPrimary = Color(0xFFE11E3C);
  static final Color lightColor = Colors.white;
  static final Color textColor = Colors.black;
  static final Color colorHeading = Color(0xFF0A151F);

  static final Color txtfieldBColors = Colors.white;
  static final Color iconColorDark = Colors.black;

  //Size
  static final double txtFieldSize = 14.0;
  static final double txtSize = 20.0;

  static final String facebook = 'assets/icons/facebook.png';
  static final String google = 'assets/icons/google.png';
  String email;

  //page

}

ThemeData DarkTheme() {
  final baseTheme = ThemeData(
    fontFamily: "Open Sans",
  );
  return baseTheme.copyWith(
    brightness: Brightness.dark,
    primaryColor: Colors.cyan,
    primaryColorLight: Colors.red,
    primaryColorDark: Color(0xFF08161b),
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

MediaQueryData _mediaQueryData;
double screenWidth;
double screenHeight;
double defaultSize;
Orientation orientation;

void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  orientation = _mediaQueryData.orientation;
  defaultSize = orientation == Orientation.landscape
      ? screenHeight * 0.024
      : screenWidth * 0.024;
}
