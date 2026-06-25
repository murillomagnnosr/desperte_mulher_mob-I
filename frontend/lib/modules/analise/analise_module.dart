import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import '../../core/network/dio_client.dart';
import 'data/datasources/analise_datasource.dart';
import 'data/datasources/analise_local_datasource.dart';
import 'data/datasources/analise_remote_datasource.dart';
import 'data/repositories/analise_repository_impl.dart';
import 'domain/repositories/analise_repository.dart';
import 'domain/usecases/get_questions.dart';
import 'domain/usecases/submit_assessment.dart';
import 'presentation/cubit/analise_cubit.dart';

/// Registra o grafo de dependências do módulo de Análise de Risco.
///
/// Ordem (de fora para dentro): DataSource → Repository → UseCases → Cubit.
///
/// INTEGRAÇÃO (Etapa 12): a fonte de dados é escolhida por `AppConfig`:
///  - `useMockData == true`  → [AnaliseLocalDataSource]  (offline, cálculo local)
///  - `useMockData == false` → [AnaliseRemoteDataSource] (API REST via Dio)
/// Trocar de mock para API é só uma flag — nenhuma outra camada muda.
void registerAnaliseModule(GetIt sl) {
  sl
    ..registerLazySingleton<AnaliseDataSource>(() {
      final config = sl<AppConfig>();
      return config.useMockData
          ? const AnaliseLocalDataSource()
          : AnaliseRemoteDataSource(sl<DioClient>());
    })
    ..registerLazySingleton<AnaliseRepository>(
      () => AnaliseRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetQuestions(sl()))
    ..registerLazySingleton(() => SubmitAssessment(sl()))
    // Cubit é FACTORY: cada tela recebe uma instância nova.
    ..registerFactory(
      () => AnaliseCubit(getQuestions: sl(), submitAssessment: sl()),
    );
}
