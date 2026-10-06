import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// نظام تايبوجرافي بخطين واضحين:
/// - Space Grotesk للعناوين (شخصية هندسية/تقنية)
/// - Inter للنصوص (وضوح وقراءة مريحة)
/// - JetBrains Mono للتاجات التقنية والتواريخ (لأن المحتوى أصلاً كود)
class AppTheme {
  AppTheme._();

  static TextTheme _textTheme(Color primary, Color secondary) {
    final headlineStyle = GoogleFonts.spaceGrotesk(
      color: primary,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
      height: 1.15,
    );
    final bodyStyle = GoogleFonts.inter(color: primary, height: 1.6);
    final bodySecondary = GoogleFonts.inter(color: secondary, height: 1.6);

    return TextTheme(
      displayLarge: headlineStyle.copyWith(fontSize: 56, fontWeight: FontWeight.w700),
      displayMedium: headlineStyle.copyWith(fontSize: 40),
      headlineLarge: headlineStyle.copyWith(fontSize: 32),
      headlineMedium: headlineStyle.copyWith(fontSize: 24),
      headlineSmall: headlineStyle.copyWith(fontSize: 20),
      titleLarge: headlineStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
      bodyLarge: bodyStyle.copyWith(fontSize: 17),
      bodyMedium: bodyStyle.copyWith(fontSize: 15),
      bodySmall: bodySecondary.copyWith(fontSize: 13),
      labelLarge: GoogleFonts.jetBrainsMono(color: primary, fontSize: 13),
      labelMedium: GoogleFonts.jetBrainsMono(color: secondary, fontSize: 12),
      labelSmall: GoogleFonts.jetBrainsMono(color: secondary, fontSize: 11, letterSpacing: 0.4),
    );
  }

  static ThemeData get dark {
    const primary = AppColors.darkTextPrimary;
    const secondary = AppColors.darkTextSecondary;
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      canvasColor: AppColors.darkBackground,
      primaryColor: AppColors.accentGold,
      dividerColor: AppColors.darkDivider,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentGold,
        secondary: AppColors.accentTeal,
        surface: AppColors.darkSurface,
        onSurface: primary,
      ),
      textTheme: _textTheme(primary, secondary),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }

  static ThemeData get light {
    const primary = AppColors.lightTextPrimary;
    const secondary = AppColors.lightTextSecondary;
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      canvasColor: AppColors.lightBackground,
      primaryColor: AppColors.accentRust,
      dividerColor: AppColors.lightDivider,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentRust,
        secondary: AppColors.accentTeal,
        surface: AppColors.lightSurface,
        onSurface: primary,
      ),
      textTheme: _textTheme(primary, secondary),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}
