import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData dark() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.dark,
      background: AppColors.background,
      surface: AppColors.surface,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      cardTheme: const CardTheme(
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          height: 1.35,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface.withOpacity(0.82),
        indicatorColor: AppColors.accent.withOpacity(0.25),
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) {
            final bool selected = states.contains(MaterialState.selected);
            return TextStyle(
              color: selected ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            );
          },
        ),
      ),
    );
  }
}
