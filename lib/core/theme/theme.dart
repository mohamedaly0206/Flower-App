import 'package:flutter/material.dart';

import '../values/fonts.gen.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData appTheme = ThemeData(
    fontFamily: FontFamily.inter,
    // colorScheme
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.whiteColor,
      onPrimaryContainer: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      onSecondary: AppColors.whiteColor,
      secondaryContainer: AppColors.whiteColor,
      onSecondaryContainer: AppColors.secondaryColor,
      tertiary: AppColors.successColor,
      onTertiary: AppColors.whiteColor,
      onTertiaryContainer: AppColors.successColor,
      error: AppColors.errorColor,
      onError: AppColors.whiteColor,
      onErrorContainer: AppColors.errorColor,
      surface: AppColors.whiteColor,
      onSurface: AppColors.blackColor,
      scrim: AppColors.loadingBackgroundColor,
      //surfaceVariant
      onSurfaceVariant: AppColors.secondaryColor,
      onTertiaryFixedVariant: AppColors.transparentColor,
    ),
    // AppBarTheme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.textStyleMedium20.copyWith(
        color: AppColors.blackColor,
      ),
    ),
    // inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      // textField border styles
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(color: AppColors.errorColor),
      ),
      // textField text styles
      hintStyle: AppTextStyles.textStyleRegular14.copyWith(
        color: AppColors.placeHolderColor,
      ),
      labelStyle: AppTextStyles.textStyleRegular14.copyWith(
        color: AppColors.greyColor,
      ),
      errorStyle: AppTextStyles.textStyleRegular14.copyWith(
        color: AppColors.errorColor,
      ),
      // textField floating label behavior
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    // ButtonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        textStyle: AppTextStyles.textStyleMedium16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        side: BorderSide(color: AppColors.primaryColor),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        // make the button expand to the max width of its parent
        minimumSize: Size(double.infinity, 48),
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.primaryColor,
        textStyle: AppTextStyles.textStyleMedium16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: AppColors.primaryColor),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        textStyle: AppTextStyles.textStyleRegular16.copyWith(
          decoration: TextDecoration.underline,
          decorationThickness: 2,
        ),
      ),
    ),
    // textTheme
    textTheme: const TextTheme(
      // appBar title
      titleLarge: AppTextStyles.textStyleMedium20,
      // section title
      titleMedium: AppTextStyles.textStyleMedium18,
      // navigation bar text
      titleSmall: AppTextStyles.textStyleSemiBold12,
      // ? it have one use in the app => exam name in start exam page
      headlineLarge: AppTextStyles.textStyleSemiBold20,
      // exam time text
      headlineSmall: AppTextStyles.textStyleRegular13,
      // button text
      headlineMedium: AppTextStyles.textStyleMedium16,
      //? it have one use in the app => time out Dialog text
      labelLarge: AppTextStyles.textStyleRegular24,
      // exam time counter text
      labelMedium: AppTextStyles.textStyleRegular20,
      displayLarge: AppTextStyles.textStyleMedium14,
      displaySmall: AppTextStyles.textStyleMedium12,
      labelSmall: AppTextStyles.textStyleMedium13,
      bodyLarge: AppTextStyles.textStyleRegular16,
      bodyMedium: AppTextStyles.textStyleRegular14,
      bodySmall: AppTextStyles.textStyleRegular12,
    ),

    // BottomNavigationBarTheme
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        return AppTextStyles.textStyleMedium14;
      }),

      backgroundColor: Colors.white,
      indicatorColor: AppColors.secondaryColor,

      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),

    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: AppColors.primaryColor, width: 2),
    ),

    radioTheme: RadioThemeData(
      side: BorderSide(color: AppColors.primaryColor, width: 2),
    ),
  );
}
