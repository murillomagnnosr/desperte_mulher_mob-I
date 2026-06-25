import '../../../../core/utils/result.dart';
import '../entities/question.dart';
import '../entities/risk_result.dart';

/// Contrato (interface) do repositório da Análise de Risco.
///
/// O domínio define O QUE precisa; a camada de dados decide COMO (mock local
/// ou API remota). Inversão de dependência (SOLID/D): UseCases dependem desta
/// abstração, nunca de Dio ou de implementações concretas.
abstract interface class AnaliseRepository {
  /// Carrega o questionário (itens validados).
  ResultFuture<List<Question>> getQuestions();

  /// Submete as respostas e obtém o resultado classificado.
  /// [answers]: mapa questionId -> optionId escolhido.
  ResultFuture<RiskResult> submitAssessment(Map<String, String> answers);
}
