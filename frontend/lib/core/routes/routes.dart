import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/admin/presentation/pages/painel_admin_page.dart';
import '../../modules/analise/domain/entities/risk_result.dart';
import '../../modules/analise/presentation/pages/analise_info_page.dart';
import '../../modules/analise/presentation/pages/perguntas_page.dart';
import '../../modules/analise/presentation/pages/resultado_page.dart';
import '../../modules/apoios/presentation/pages/apoios_page.dart';
import '../../modules/authentication/presentation/pages/cadastro_page.dart';
import '../../modules/authentication/presentation/pages/login_page.dart';
import '../../modules/contato/presentation/pages/contato_page.dart';
import '../../modules/denuncia/presentation/pages/denuncia_page.dart';
import '../../modules/home/presentation/pages/home_page.dart';
import '../../modules/observatorio/presentation/pages/observatorio_page.dart';
import '../../modules/profile/presentation/pages/perfil_page.dart';
import '../../modules/settings/presentation/pages/config_page.dart';
import '../../modules/sobre/presentation/pages/sobre_page.dart';
import '../../modules/termos/presentation/pages/termos_page.dart';
import '../../shared/widgets/not_found_page.dart';
import 'app_routes.dart';

/// Configuração central do roteador (GoRouter).
///
/// - Navegação declarativa baseada em URL (essencial para a versão Web).
/// - `refreshListenable` (SessionController) faz o `redirect` reavaliar quando
///   a sessão muda (login/logout).
/// - `redirect` protege as rotas da área Acolhe: sem sessão, manda ao login.
/// - `errorBuilder` trata rotas inexistentes (404).
class AppRouter {
  AppRouter({
    required this.navigatorKey,
    required this.isAuthenticated,
    required this.refreshListenable,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  /// Fonte de verdade da sessão (injetada via SessionController).
  final bool Function() isAuthenticated;

  /// Reavalia os redirects quando a sessão muda (login/logout).
  final Listenable refreshListenable;

  late final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: refreshListenable,
    redirect: _guard,
    errorBuilder: (context, state) => NotFoundPage(uri: state.uri.toString()),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        redirect: (_, __) => AppRoutes.home,
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomePage(),
      ),
      // --- Institucionais ------------------------------------------------
      GoRoute(
        path: AppRoutes.sobre,
        name: AppRoutes.sobreName,
        builder: (context, state) => const SobrePage(),
      ),
      GoRoute(
        path: AppRoutes.apoios,
        name: AppRoutes.apoiosName,
        builder: (context, state) => const ApoiosPage(),
      ),
      GoRoute(
        path: AppRoutes.observatorio,
        name: AppRoutes.observatorioName,
        builder: (context, state) => const ObservatorioPage(),
      ),
      GoRoute(
        path: AppRoutes.contato,
        name: AppRoutes.contatoName,
        builder: (context, state) => const ContatoPage(),
      ),
      GoRoute(
        path: AppRoutes.termos,
        name: AppRoutes.termosName,
        builder: (context, state) => const TermosPage(),
      ),
      // --- Fluxo de Análise de Risco -------------------------------------
      GoRoute(
        path: AppRoutes.analiseInfo,
        name: AppRoutes.analiseInfoName,
        builder: (context, state) => const AnaliseInfoPage(),
      ),
      GoRoute(
        path: AppRoutes.perguntas,
        name: AppRoutes.perguntasName,
        builder: (context, state) => const PerguntasPage(),
      ),
      GoRoute(
        path: AppRoutes.resultado,
        name: AppRoutes.resultadoName,
        builder: (context, state) =>
            ResultadoPage(result: state.extra as RiskResult?),
      ),
      // --- Denúncia ------------------------------------------------------
      GoRoute(
        path: AppRoutes.denuncia,
        name: AppRoutes.denunciaName,
        builder: (context, state) => const DenunciaPage(),
      ),
      // --- Acolhe (auth) -------------------------------------------------
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.cadastro,
        name: AppRoutes.cadastroName,
        builder: (context, state) => const CadastroPage(),
      ),
      // --- Acolhe (protegidas) -------------------------------------------
      GoRoute(
        path: AppRoutes.painelAdmin,
        name: AppRoutes.painelAdminName,
        builder: (context, state) => const PainelAdminPage(),
      ),
      GoRoute(
        path: AppRoutes.perfil,
        name: AppRoutes.perfilName,
        builder: (context, state) => const PerfilPage(),
      ),
      GoRoute(
        path: AppRoutes.config,
        name: AppRoutes.configName,
        builder: (context, state) => const ConfigPage(),
      ),
    ],
  );

  /// Redireciona rotas protegidas para o login quando não há sessão.
  String? _guard(BuildContext context, GoRouterState state) {
    final goingToProtected = AppRoutes.protectedPaths.contains(state.uri.path);
    if (goingToProtected && !isAuthenticated()) {
      return AppRoutes.login;
    }
    return null;
  }
}
