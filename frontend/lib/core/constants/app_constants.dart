/// Constantes técnicas e de negócio (não textuais).
abstract final class AppConstants {
  AppConstants._();

  // Breakpoints de responsividade (Etapa 13).
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;
  // > tabletMaxWidth => desktop

  // Design size de referência para flutter_screenutil (iPhone X-ish).
  static const double designWidth = 390;
  static const double designHeight = 844;

  // Persistência (shared_preferences keys).
  static const String kAccessToken = 'desperte.access_token';
  static const String kRefreshToken = 'desperte.refresh_token';
  static const String kThemeMode = 'desperte.theme_mode';
  static const String kLocale = 'desperte.locale';

  // Timeouts de rede (ms).
  static const int connectTimeoutMs = 15000;
  static const int receiveTimeoutMs = 20000;

  // ---------------------------------------------------------------------------
  // Faixas de classificação de risco (LÓGICA DE NEGÓCIO — não alterar).
  // Limite superior (inclusive) de cada faixa, em %.
  // ---------------------------------------------------------------------------
  static const double riskVeryLowMax = 20;
  static const double riskLowMax = 40;
  static const double riskModerateMax = 60;
  static const double riskHighMax = 80;
  // acima de 80 => Extremo (100)
}
