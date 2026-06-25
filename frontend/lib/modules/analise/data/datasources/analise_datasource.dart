import '../../domain/entities/risk_result.dart';
import '../models/question_model.dart';

/// Contrato de fonte de dados da Análise de Risco.
///
/// Duas implementações: [AnaliseLocalDataSource] (mock/offline, usada agora)
/// e [AnaliseRemoteDataSource] (API real, ligada na Etapa 12). O repositório
/// depende apenas desta abstração — trocar a fonte não afeta domínio nem UI.
abstract interface class AnaliseDataSource {
  Future<List<QuestionModel>> fetchQuestions();
  Future<RiskResult> evaluate(Map<String, String> answers);
}
