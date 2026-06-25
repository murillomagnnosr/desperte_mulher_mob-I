/// Catálogo central de rotas (paths + names).
///
/// Manter paths e names como constantes evita strings mágicas espalhadas e
/// permite navegação type-safe via `context.goNamed(AppRoutes.homeName)`.
/// Os paths espelham o site original (`/sobre`, `/analise`, etc.).
abstract final class AppRoutes {
  AppRoutes._();

  // Públicas (institucionais)
  static const String splash = '/';
  static const String splashName = 'splash';

  static const String home = '/inicio';
  static const String homeName = 'home';

  static const String sobre = '/sobre';
  static const String sobreName = 'sobre';

  static const String apoios = '/apoios';
  static const String apoiosName = 'apoios';

  static const String observatorio = '/observatorio';
  static const String observatorioName = 'observatorio';

  static const String contato = '/contato';
  static const String contatoName = 'contato';

  static const String termos = '/termos-de-uso';
  static const String termosName = 'termos';

  // Fluxo de Análise de Risco (núcleo — lógica preservada)
  static const String analiseInfo = '/analise';
  static const String analiseInfoName = 'analise-info';

  static const String perguntas = '/analise/perguntas';
  static const String perguntasName = 'perguntas';

  static const String resultado = '/analise/resultado';
  static const String resultadoName = 'resultado';

  // Denúncia anônima
  static const String denuncia = '/denuncia';
  static const String denunciaName = 'denuncia';

  // Autenticação / área Acolhe
  static const String login = '/acolhe/login';
  static const String loginName = 'login';

  static const String cadastro = '/acolhe/cadastro';
  static const String cadastroName = 'cadastro';

  // Área logada (Acolhe)
  static const String painelAdmin = '/acolhe/painel';
  static const String painelAdminName = 'painel-admin';

  static const String perfil = '/acolhe/perfil';
  static const String perfilName = 'perfil';

  static const String config = '/acolhe/configuracoes';
  static const String configName = 'config';

  /// Rotas que exigem autenticação (usado pelo redirect do GoRouter).
  static const Set<String> protectedPaths = {
    painelAdmin,
    perfil,
    config,
  };
}
