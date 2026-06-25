import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/risk_result.dart';
import '../../domain/repositories/analise_repository.dart';
import '../datasources/analise_datasource.dart';

/// Implementação do [AnaliseRepository].
///
/// Responsabilidade: orquestrar a fonte de dados e CONVERTER exceções de
/// infraestrutura (Dio, parsing) em [Failure]s de domínio. Domínio e UI nunca
/// veem `DioException` — só `Failure`.
class AnaliseRepositoryImpl implements AnaliseRepository {
  const AnaliseRepositoryImpl(this._dataSource);
  final AnaliseDataSource _dataSource;

  @override
  ResultFuture<List<Question>> getQuestions() async {
    try {
      final questions = await _dataSource.fetchQuestions();
      return Ok(questions);
    } on DioException catch (e) {
      return Err(_mapDio(e));
    } catch (_) {
      return const Err(UnexpectedFailure());
    }
  }

  @override
  ResultFuture<RiskResult> submitAssessment(Map<String, String> answers) async {
    try {
      final result = await _dataSource.evaluate(answers);
      return Ok(result);
    } on DioException catch (e) {
      return Err(_mapDio(e));
    } catch (_) {
      return const Err(UnexpectedFailure());
    }
  }

  Failure _mapDio(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const NetworkFailure();
    }
    final code = e.response?.statusCode;
    if (code == 401 || code == 403) return const AuthFailure();
    return ServerFailure(
      e.response?.data?.toString() ?? 'Erro no servidor.',
      statusCode: code,
    );
  }
}
