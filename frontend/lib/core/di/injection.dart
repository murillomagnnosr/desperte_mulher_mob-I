import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/analise/analise_module.dart';
import '../config/app_config.dart';
import '../network/dio_client.dart';
import '../routes/navigation_service.dart';
import '../session/session_controller.dart';

/// Container de injeção de dependências (Service Locator) via GetIt.
///
/// Centraliza a criação e o ciclo de vida das dependências, mantendo as
/// camadas desacopladas (Dependency Inversion / "D" do SOLID): a UI pede
/// `sl<XUseCase>()` sem saber como ele é construído.
///
/// Em escala, este registro manual pode ser gerado automaticamente com
/// `injectable` + `build_runner` (anotando classes com @injectable). Mantemos
/// a versão manual aqui por ser transparente e 100% legível para a banca.
final GetIt sl = GetIt.instance;

Future<void> configureDependencies(AppConfig config) async {
  // --- Externos / Infra ------------------------------------------------------
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerSingleton<AppConfig>(config)
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerSingleton<NavigationService>(NavigationService())
    ..registerSingleton<SessionController>(SessionController())
    ..registerLazySingleton<DioClient>(
      () => DioClient(config: sl(), prefs: sl()),
    );

  // --- Módulos ---------------------------------------------------------------
  // Cada feature expõe um `register<Feature>(sl)` que registra seus
  // DataSources -> Repositories -> UseCases -> Cubits.
  registerAnaliseModule(sl);
  // Próximas etapas: registerAuthModule(sl); registerDenunciaModule(sl); ...
}
