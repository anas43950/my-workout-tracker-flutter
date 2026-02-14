import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracker/ui/theme/app_text_styles.dart';
import 'package:workout_tracker/ui/theme/colors.dart';
import 'package:workout_tracker/ui/theme/dimensions.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: white,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: white,
  ),
  textTheme: GoogleFonts.outfitTextTheme().apply(bodyColor: black),
  radioTheme: RadioThemeData(
    fillColor: WidgetStatePropertyAll(black),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.blue;
      }
      return Colors.white;
    }),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.inputFieldsBorderRadius),
      borderSide: BorderSide.none,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: white, backgroundColor: Colors.redAccent),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: black,
      foregroundColor: Colors.white,
      padding: EdgeInsets.all(Dimensions.buttonPadding),
      textStyle: AppTextStyles.labelMedium.copyWith(
        fontFamily: GoogleFonts.redHatDisplay().fontFamily,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.inputFieldsBorderRadius)),
    ),
  ),
  dividerTheme: DividerThemeData(thickness: 0.0),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
  dialogTheme: DialogThemeData(
    backgroundColor: white,
  ),
);
