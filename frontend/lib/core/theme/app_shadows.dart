import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Tokens de elevação/sombra.
///
/// Sombras suaves e de baixa opacidade — coerentes com um visual calmo.
/// Cada nível corresponde a uma "altura" perceptível na hierarquia visual.
abstract final class AppShadows {
  AppShadows._();

  /// Cartões em repouso (listas, seções).
  static List<BoxShadow> get sm => [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  /// Cartões em destaque / hover.
  static List<BoxShadow> get md => [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.10),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ];

  /// Modais, drawers, elementos flutuantes.
  static List<BoxShadow> get lg => [
        BoxShadow(
          color: AppColors.primaryDark.withValues(alpha: 0.16),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];
}
