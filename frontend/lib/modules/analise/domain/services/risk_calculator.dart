import '../entities/question.dart';
import '../entities/risk_level.dart';
import '../entities/risk_result.dart';

/// Serviço de domínio que converte respostas em um [RiskResult].
///
/// É regra de NEGÓCIO pura (sem Flutter/HTTP) — fácil de testar isoladamente.
/// Preserva o mecanismo do site: soma ponderada das respostas, normalizada
/// para 0..100% e classificada em 5 faixas.
///
/// Observação acadêmica: no sistema em produção, esse cálculo roda no
/// BACKEND (ver diagrama de sequência, Etapa 3). Mantemos a mesma lógica aqui
/// para o modo offline/mock e para os testes de unidade; a versão remota
/// apenas delega à API.
class RiskCalculator {
  const RiskCalculator();

  /// [answers]: mapa questionId -> AnswerOption escolhida.
  RiskResult calculate({
    required List<Question> questions,
    required Map<String, AnswerOption> answers,
  }) {
    double totalScore = 0;
    double totalMax = 0;

    final perCategoryScore = <RiskCategory, double>{};
    final perCategoryMax = <RiskCategory, double>{};

    for (final q in questions) {
      final selected = answers[q.id];
      final score = selected?.score ?? 0;
      totalScore += score;
      totalMax += q.maxScore;

      perCategoryScore.update(q.category, (v) => v + score,
          ifAbsent: () => score,);
      perCategoryMax.update(q.category, (v) => v + q.maxScore,
          ifAbsent: () => q.maxScore,);
    }

    final percent = totalMax == 0 ? 0.0 : (totalScore / totalMax) * 100;
    final level = RiskLevel.fromPercent(percent);

    final breakdown = <String, double>{
      for (final c in perCategoryScore.keys)
        c.titulo: perCategoryMax[c] == 0
            ? 0.0
            : (perCategoryScore[c]! / perCategoryMax[c]!) * 100,
    };

    return RiskResult(
      percent: double.parse(percent.toStringAsFixed(1)),
      level: level,
      categoryBreakdown: breakdown,
      recommendations: _recommendationsFor(level),
    );
  }

  List<String> _recommendationsFor(RiskLevel level) {
    final base = [
      'Você não está sozinha. Procure a rede de apoio quando se sentir segura.',
      'Em emergência, ligue 190 (Polícia) ou 180 (Central de Atendimento à Mulher).',
    ];
    if (level.isUrgent) {
      return [
        'Considere acionar imediatamente a rede de proteção.',
        'Procure a Casa da Mulher Brasileira ou a Ouvidoria da Mulher.',
        'Avalie solicitar uma Medida Protetiva de Urgência.',
        ...base,
      ];
    }
    return [
      'Mantenha-se informada e atenta aos sinais.',
      'Fortaleça sua rede de apoio (pessoas de confiança).',
      ...base,
    ];
  }
}
