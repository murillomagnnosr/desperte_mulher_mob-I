import 'package:flutter/material.dart';

/// Paleta central do Desperte Mulher.
///
/// Tema HÍBRIDO (Mockup 01 + 02):
///  - Roxo/violeta como cor primária  -> acolhimento, dignidade, força feminina.
///  - Teal/azul institucional         -> confiança, oficialidade (parceiros públicos).
///  - Coral                           -> chamadas para ação calorosas, porém calmas.
///
/// Todas as cores foram escolhidas pensando em ACESSIBILIDADE: os pares
/// texto/fundo atingem contraste mínimo WCAG AA. Nada de cores puras
/// "gritantes" — o público são mulheres em situação de vulnerabilidade.
///
/// Esta classe é puramente estática (sem instância): centraliza os tokens
/// de cor para que NENHUM widget use `Color(0xFF...)` solto pelo código.
abstract final class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // PRIMÁRIA — Violeta (acolhimento + dignidade)
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFF6A2C8C);
  static const Color primaryDark = Color(0xFF4A1D63);
  static const Color primaryLight = Color(0xFF9B6BBF);
  static const Color primaryContainer = Color(0xFFEEDFF7);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF2C0E40);

  // ---------------------------------------------------------------------------
  // SECUNDÁRIA — Teal/Azul (confiança institucional)
  // ---------------------------------------------------------------------------
  static const Color secondary = Color(0xFF0E6E7D);
  static const Color secondaryDark = Color(0xFF08454F);
  static const Color secondaryLight = Color(0xFF4FA3AF);
  static const Color secondaryContainer = Color(0xFFD3EEF1);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF00272E);

  // ---------------------------------------------------------------------------
  // ACCENT — Coral (CTA calorosa)
  // ---------------------------------------------------------------------------
  static const Color accent = Color(0xFFF2685B);
  static const Color accentDark = Color(0xFFC74A3F);
  static const Color accentLight = Color(0xFFFF9A8F);
  static const Color onAccent = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // NÍVEIS DE RISCO (semântica do negócio — NÃO alterar significado)
  // Muito Baixo 20% · Baixo 40% · Moderado 60% · Alto 80% · Extremo 100%
  // ---------------------------------------------------------------------------
  static const Color riskVeryLow = Color(0xFF2E9E6B); // verde
  static const Color riskLow = Color(0xFF7CB342); // verde-limão
  static const Color riskModerate = Color(0xFFF2A900); // âmbar
  static const Color riskHigh = Color(0xFFEF6C00); // laranja
  static const Color riskExtreme = Color(0xFFC62828); // vermelho

  // ---------------------------------------------------------------------------
  // SEMÂNTICAS (feedback)
  // ---------------------------------------------------------------------------
  static const Color success = Color(0xFF2E9E6B);
  static const Color warning = Color(0xFFF2A900);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF0E6E7D);
  static const Color onError = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // NEUTROS / SUPERFÍCIES (light)
  // ---------------------------------------------------------------------------
  static const Color background = Color(0xFFFFFBFE); // branco "quente"
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF4EFF6);
  static const Color surfaceTint = Color(0xFFFAF5FC);
  static const Color outline = Color(0xFFD8CFE0);
  static const Color outlineVariant = Color(0xFFEDE7F1);
  static const Color scrim = Color(0x99000000);

  // Texto
  static const Color textPrimary = Color(0xFF1C1B1F);
  static const Color textSecondary = Color(0xFF49454F);
  static const Color textTertiary = Color(0xFF79747E);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textDisabled = Color(0xFFBDB6C4);

  // ---------------------------------------------------------------------------
  // NEUTROS / SUPERFÍCIES (dark) — base para tema escuro futuro
  // ---------------------------------------------------------------------------
  static const Color backgroundDark = Color(0xFF141019);
  static const Color surfaceDark = Color(0xFF1E1823);
  static const Color surfaceVariantDark = Color(0xFF2A2233);
  static const Color outlineDark = Color(0xFF483F54);
  static const Color textPrimaryDark = Color(0xFFEDE6F2);
  static const Color textSecondaryDark = Color(0xFFBDB2C7);

  // ---------------------------------------------------------------------------
  // GRADIENTES
  // ---------------------------------------------------------------------------
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primary, secondary],
  );

  static const LinearGradient ctaGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [accent, accentDark],
  );

  /// Cor associada a um percentual de risco do questionário (0..100).
  /// Mantém a classificação oficial do site (5 faixas).
  static Color riskColor(double percent) {
    if (percent <= 20) return riskVeryLow;
    if (percent <= 40) return riskLow;
    if (percent <= 60) return riskModerate;
    if (percent <= 80) return riskHigh;
    return riskExtreme;
  }
}
