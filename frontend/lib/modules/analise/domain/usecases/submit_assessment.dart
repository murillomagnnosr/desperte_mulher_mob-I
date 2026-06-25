import '../../../../core/utils/result.dart';
import '../entities/risk_result.dart';
import '../repositories/analise_repository.dart';

/// UseCase: submeter respostas e obter o resultado de risco.
class SubmitAssessment {
  const SubmitAssessment(this._repository);
  final AnaliseRepository _repository;

  /// [answers]: mapa questionId -> optionId escolhido.
  ResultFuture<RiskResult> call(Map<String, String> answers) =>
      _repository.submitAssessment(answers);
}
