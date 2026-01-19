import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracker/ui/theme/colors.dart';
import 'package:workout_tracker/ui/theme/dimensions.dart';
import 'package:workout_tracker/ui/theme/text_styles.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: GoogleFonts.outfit().fontFamily,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.inputFieldsBorderRadius),
      borderSide: BorderSide.none,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: black,
      foregroundColor: Colors.white,
      padding: EdgeInsets.all(Dimensions.buttonPadding),
      textStyle: TextStyles.bodyMedium.copyWith(
        fontFamily: GoogleFonts.redHatDisplay().fontFamily,
      ),
    ),
  ),
);
