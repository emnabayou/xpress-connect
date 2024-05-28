import 'package:flutter/material.dart';
import 'package:xcmobile/1-core/app_colors.dart';

class AppThemes {
  static final theme = ThemeData(
      useMaterial3: true,
      // Define the default brightness and colors.
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryContainer,
        tertiary: AppColors.tertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        error: AppColors.error,
        errorContainer: AppColors.errorContainer,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(0.0),
        filled: true,
        fillColor: AppColors.inputFill,
        hintStyle: const TextStyle(
          color: AppColors.iconColor,
          fontSize: 14.0,
        ),
        labelStyle: const TextStyle(
          color: AppColors.iconColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.withOpacity(0.7), width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.black.withOpacity(0.8),
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black.withOpacity(0.2), width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));
}
