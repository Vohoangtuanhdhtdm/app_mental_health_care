import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const _fallback = ['SF Pro Display', 'SF Pro Text', 'Roboto'];

  static TextTheme light = TextTheme(
    displayLarge: TextStyle(
      fontFamilyFallback: _fallback,
      fontWeight: FontWeight.w700,
      fontSize: 48,
      height: 1.15,
      letterSpacing: -0.5,
      color: AppColors.navy,
    ),
    headlineMedium: TextStyle(
      fontFamilyFallback: _fallback,
      fontWeight: FontWeight.w700,
      fontSize: 28,
      height: 1.2,
      color: AppColors.navy,
    ),
    titleLarge: TextStyle(
      fontFamilyFallback: _fallback,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 1.3,
    ),
    bodyLarge: TextStyle(
      fontFamilyFallback: _fallback,
      fontSize: 16,
      height: 1.45,
    ),
    bodyMedium: TextStyle(
      fontFamilyFallback: _fallback,
      fontSize: 14,
      height: 1.45,
    ),
    labelLarge: TextStyle(
      fontFamilyFallback: _fallback,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: 0.1,
    ),
  );

  static TextTheme dark = light.apply(
    bodyColor: const Color(0xFFE8F1F8),
    displayColor: const Color(0xFFE8F1F8),
  );
}
