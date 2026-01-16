import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.mandyRed, // Change this one line to change your whole app vibe
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      // ignore: deprecated_member_use
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
      defaultRadius: 12.0, // Global rounded corners for all buttons/cards
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.mandyRed,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      // ignore: deprecated_member_use
      useTextTheme: true,
      defaultRadius: 12.0,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}