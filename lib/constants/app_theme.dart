import 'package:bookpad/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(

    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.mossGreen,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
            color: Colors.white
        )
    ),

    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 20,
          color: AppColors.richBlack,
          fontWeight: FontWeight.bold
      ),
      titleMedium: TextStyle(
          fontSize: 18,
          color: AppColors.richBlack,
          fontWeight: FontWeight.bold
      ),
      titleSmall: TextStyle(
          fontSize: 16,
          color: AppColors.richBlack,
          fontWeight: FontWeight.bold
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.richBlack,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mossGreen,
          fixedSize: Size(300, 50),
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
        )
    ),

    iconTheme: IconThemeData(
        color: Colors.black,
        size: 26
    ),
  );
}