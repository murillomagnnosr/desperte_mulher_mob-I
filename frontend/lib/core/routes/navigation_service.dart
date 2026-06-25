import 'package:flutter/widgets.dart';

/// Serviço de navegação desacoplado do `BuildContext`.
///
/// Permite navegar a partir de camadas que não têm contexto (ex.: um
/// interceptor do Dio que detecta 401 e precisa enviar o usuário ao login).
/// Registrado no GetIt e conectado ao GoRouter via [navigatorKey].
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');

  BuildContext? get _context => navigatorKey.currentContext;

  /// Disponível para casos extremos; a navegação primária usa GoRouter
  /// diretamente via `context.goNamed(...)`.
  BuildContext? get context => _context;
}
