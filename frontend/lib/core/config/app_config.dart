/// Ambientes de execução (flavors).
enum AppEnvironment { development, staging, production }

/// Configuração por ambiente, injetada na inicialização do app.
///
/// Mantém a URL da API e flags fora do código de UI. Em build real, os
/// valores podem vir de `--dart-define`. Aqui usamos um default seguro
/// para desenvolvimento local.
final class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    this.enableLogging = true,
    this.useMockData = false,
  });

  final AppEnvironment environment;
  final String apiBaseUrl;
  final bool enableLogging;

  /// Quando `true`, os módulos usam DataSources LOCAIS (mock) em vez da API.
  /// Permite rodar o app sem backend. Sobrescreva com
  /// `--dart-define=USE_MOCK=false` para consumir a API real.
  final bool useMockData;

  bool get isProduction => environment == AppEnvironment.production;

  /// Configuração resolvida a partir de `--dart-define=ENV=...`.
  factory AppConfig.fromEnvironment() {
    const env = String.fromEnvironment('ENV', defaultValue: 'development');
    // Default: dev usa mock; demais ambientes usam API. Override por dart-define.
    const mockOverride = String.fromEnvironment('USE_MOCK', defaultValue: '');

    switch (env) {
      case 'production':
        return const AppConfig(
          environment: AppEnvironment.production,
          apiBaseUrl: 'https://api.despertemulher.org/api/v1',
          enableLogging: false,
          useMockData: mockOverride == 'true',
        );
      case 'staging':
        return const AppConfig(
          environment: AppEnvironment.staging,
          apiBaseUrl: 'https://staging-api.despertemulher.org/api/v1',
          useMockData: mockOverride == 'true',
        );
      case 'development':
      default:
        return const AppConfig(
          environment: AppEnvironment.development,
          // Em emulador Android use 10.0.2.2; em web/desktop, localhost.
          apiBaseUrl: 'http://localhost:3333/api/v1',
          useMockData: mockOverride != 'false',
        );
    }
  }
}
