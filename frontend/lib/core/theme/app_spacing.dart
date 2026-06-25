/// Escala de espaçamento baseada em múltiplos de 4 (padrão Material).
///
/// Centralizar o spacing evita "números mágicos" (`SizedBox(height: 13)`)
/// espalhados pelo código e garante ritmo vertical/horizontal consistente.
/// Usado em conjunto com `flutter_screenutil` para escalar em telas grandes.
abstract final class AppSpacing {
  AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  /// Padding horizontal padrão do conteúdo em telas mobile.
  static const double pageHorizontalMobile = 20;

  /// Largura máxima de conteúdo legível em telas largas (web/desktop).
  static const double maxContentWidth = 1180;

  /// Largura máxima de um formulário/coluna de leitura.
  static const double maxFormWidth = 480;
}
