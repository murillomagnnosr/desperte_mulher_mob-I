import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Sistema tipográfico.
///
/// Duas famílias, papéis distintos (princípio do tema híbrido):
///  - **Poppins** (humanista, levemente arredondada) -> títulos/display.
///    Transmite calor e acolhimento.
///  - **Inter** (neutra, altíssima legibilidade) -> textos longos/corpo.
///    Transmite seriedade institucional e facilita a leitura de conteúdo
///    sensível por usuárias possivelmente em estresse.
///
/// Retornamos um [TextTheme] do Material 3 já configurado, consumido por
/// [AppTheme]. Nenhum widget deve instanciar `GoogleFonts` diretamente.
abstract final class AppTypography {
  AppTypography._();

  static TextStyle get _poppins => GoogleFonts.poppins();
  static TextStyle get _inter => GoogleFonts.inter();

  static TextTheme textTheme(Color textColor, Color mutedColor) {
    return TextTheme(
      // Display — grandes chamadas (hero)
      displayLarge: _poppins.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        color: textColor,
      ),
      displayMedium: _poppins.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: textColor,
      ),
      displaySmall: _poppins.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: textColor,
      ),
      // Headline — títulos de seção
      headlineLarge: _poppins.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: _poppins.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: _poppins.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      // Title — cartões, app bars
      titleLarge: _poppins.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: _inter.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: _inter.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      // Body — texto corrente
      bodyLarge: _inter.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),
      bodyMedium: _inter.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: mutedColor,
      ),
      bodySmall: _inter.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: mutedColor,
      ),
      // Label — botões, chips
      labelLarge: _inter.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: textColor,
      ),
      labelMedium: _inter.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: mutedColor,
      ),
      labelSmall: _inter.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
        color: mutedColor,
      ),
    );
  }

  /// Light theme conveniente.
  static TextTheme get light =>
      textTheme(AppColors.textPrimary, AppColors.textSecondary);

  /// Dark theme conveniente.
  static TextTheme get dark =>
      textTheme(AppColors.textPrimaryDark, AppColors.textSecondaryDark);
}
