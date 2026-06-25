import 'package:desperte_mulher/modules/analise/domain/entities/question.dart';
import 'package:desperte_mulher/modules/analise/domain/entities/risk_level.dart';
import 'package:desperte_mulher/modules/analise/domain/services/risk_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

/// Testes da regra de negócio central (Etapa 15).
/// Como o domínio é Dart puro, testamos sem device/Flutter.
void main() {
  const calc = RiskCalculator();

  // Duas perguntas, cada uma com opções Sim(2) / Não(0). Máximo = 4 pontos.
  final q1 = Question(
    id: 'q1',
    category: RiskCategory.violencia,
    text: 'Pergunta 1',
    options: const [
      AnswerOption(id: 'sim', label: 'Sim', score: 2),
      AnswerOption(id: 'nao', label: 'Não', score: 0),
    ],
  );
  final q2 = Question(
    id: 'q2',
    category: RiskCategory.controle,
    text: 'Pergunta 2',
    options: const [
      AnswerOption(id: 'sim', label: 'Sim', score: 2),
      AnswerOption(id: 'nao', label: 'Não', score: 0),
    ],
  );
  final questions = [q1, q2];

  test('todas "Não" → 0% e Muito Baixo', () {
    final result = calc.calculate(
      questions: questions,
      answers: {'q1': q1.options[1], 'q2': q2.options[1]},
    );
    expect(result.percent, 0);
    expect(result.level, RiskLevel.muitoBaixo);
  });

  test('uma "Sim" e uma "Não" → 50% e Moderado', () {
    final result = calc.calculate(
      questions: questions,
      answers: {'q1': q1.options[0], 'q2': q2.options[1]},
    );
    expect(result.percent, 50);
    expect(result.level, RiskLevel.moderado);
  });

  test('todas "Sim" → 100% e Extremo (urgente)', () {
    final result = calc.calculate(
      questions: questions,
      answers: {'q1': q1.options[0], 'q2': q2.options[0]},
    );
    expect(result.percent, 100);
    expect(result.level, RiskLevel.extremo);
    expect(result.level.isUrgent, isTrue);
    expect(result.recommendations, isNotEmpty);
  });

  test('quebra por categoria é calculada', () {
    final result = calc.calculate(
      questions: questions,
      answers: {'q1': q1.options[0], 'q2': q2.options[1]},
    );
    expect(result.categoryBreakdown['Histórico de violência'], 100);
    expect(result.categoryBreakdown['Controle e isolamento'], 0);
  });
}
