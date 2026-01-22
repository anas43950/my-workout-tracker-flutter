import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracker/ui/theme/colors.dart';
import 'package:workout_tracker/ui/theme/dimensions.dart';
import 'package:workout_tracker/ui/theme/text_styles.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: white,
  textTheme: GoogleFonts.outfitTextTheme().apply(bodyColor: black),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.inputFieldsBorderRadius),
      borderSide: BorderSide.none,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: white, backgroundColor: black),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: black,
      foregroundColor: Colors.white,
      padding: EdgeInsets.all(Dimensions.buttonPadding),
      textStyle: TextStyles.labelMedium.copyWith(
        fontFamily: GoogleFonts.redHatDisplay().fontFamily,
      ),
    ),
  ),
);
