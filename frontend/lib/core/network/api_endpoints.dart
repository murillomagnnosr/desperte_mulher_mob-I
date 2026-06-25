/// Endpoints da API REST (Etapa 10/12).
///
/// Centralizados para que repositórios não componham URLs manualmente.
/// Os paths são relativos à `apiBaseUrl` definida em AppConfig.
abstract final class ApiEndpoints {
  ApiEndpoints._();

  // Auth (Acolhe)
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String me = '/auth/me';

  // Análise de Risco
  static const String questions = '/questions';
  static const String submitAnswers = '/answers';
  static const String results = '/results';

  // Denúncia anônima
  static const String reports = '/reports';

  // Conteúdo institucional
  static const String partners = '/partners';
  static const String observatory = '/observatory/stats';
  static const String contacts = '/contacts';
}
