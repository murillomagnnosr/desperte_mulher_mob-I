import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/risk_level.dart';
import '../../domain/entities/risk_result.dart';
import '../models/question_model.dart';
import 'analise_datasource.dart';

/// Fonte de dados REMOTA (API REST). Ligada na Etapa 12.
///
/// Apenas converse com a API: o cálculo do risco é feito no backend
/// (ver Etapa 3). Aqui só fazemos request/parse.
class AnaliseRemoteDataSource implements AnaliseDataSource {
  const AnaliseRemoteDataSource(this._client);
  final DioClient _client;

  @override
  Future<List<QuestionModel>> fetchQuestions() async {
    final res = await _client.dio.get<List<dynamic>>(ApiEndpoints.questions);
    return (res.data ?? [])
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<RiskResult> evaluate(Map<String, String> answers) async {
    final res = await _client.dio.post<Map<String, dynamic>>(
      ApiEndpoints.submitAnswers,
      data: {'answers': answers},
    );
    final data = res.data!;
    return RiskResult(
      percent: (data['percent'] as num).toDouble(),
      level: RiskLevel.values.byName(data['level'] as String),
      categoryBreakdown: (data['categoryBreakdown'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, (v as num).toDouble())),
      recommendations: (data['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }
}
