import 'package:flutter/material.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';

/// Ponto de entrada único da aplicação.
///
/// Fluxo de inicialização:
///  1. Garante o binding do Flutter (necessário antes de chamadas async).
///  2. Resolve a configuração do ambiente (dev/staging/prod).
///  3. Configura o container de injeção de dependências (GetIt).
///  4. Sobe a árvore de widgets ([DesperteMulherApp]).
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  await configureDependencies(config);

  runApp(const DesperteMulherApp());
}
