import '../../domain/entities/question.dart';
import '../../domain/entities/risk_result.dart';
import '../../domain/services/risk_calculator.dart';
import '../models/question_model.dart';
import 'analise_datasource.dart';

/// Fonte de dados LOCAL (offline/mock).
///
/// Fornece um banco de perguntas REPRESENTATIVO, organizado pelas categorias
/// oficiais, e calcula o risco localmente via [RiskCalculator]. Permite rodar
/// e demonstrar o app sem backend.
///
/// ⚠️ Os itens e pesos abaixo são um modelo de demonstração. O instrumento
/// científico validado (metodologia Desperte Mulher) deve substituí-los — a
/// estrutura (categorias, opções com peso, normalização 0..100%) já está pronta
/// para recebê-lo sem mudança de código.
class AnaliseLocalDataSource implements AnaliseDataSource {
  const AnaliseLocalDataSource({this.calculator = const RiskCalculator()});
  final RiskCalculator calculator;

  // Opções padrão reutilizadas (Sim/Às vezes/Não).
  static const _sim = AnswerOptionModel(id: 'sim', label: 'Sim', score: 2);
  static const _asVezes =
      AnswerOptionModel(id: 'asvezes', label: 'Às vezes', score: 1);
  static const _nao = AnswerOptionModel(id: 'nao', label: 'Não', score: 0);
  static const _padrao = [_sim, _asVezes, _nao];

  static const _bank = <QuestionModel>[
    QuestionModel(
      id: 'q1',
      category: RiskCategory.violencia,
      text: 'Você já sofreu agressão física por parte do(a) parceiro(a)?',
      options: _padrao,
    ),
    QuestionModel(
      id: 'q2',
      category: RiskCategory.violencia,
      text: 'Você recebe ameaças ou é humilhada com frequência?',
      options: _padrao,
    ),
    QuestionModel(
      id: 'q3',
      category: RiskCategory.controle,
      text: 'Seu dinheiro, documentos ou saídas são controlados por ele(a)?',
      options: _padrao,
    ),
    QuestionModel(
      id: 'q4',
      category: RiskCategory.controle,
      text: 'Você foi afastada de familiares e amigos (isolamento)?',
      options: _padrao,
    ),
    QuestionModel(
      id: 'q5',
      category: RiskCategory.escalada,
      text: 'Ele(a) tem acesso a armas de fogo?',
      options: _padrao,
    ),
    QuestionModel(
      id: 'q6',
      category: RiskCategory.escalada,
      text: 'As agressões têm ficado mais frequentes ou intensas?',
      options: _padrao,
    ),
    QuestionModel(
      id: 'q7',
      category: RiskCategory.dependentes,
      text: 'Há crianças ou dependentes expostos à violência?',
      options: _padrao,
    ),
    QuestionModel(
      id: 'q8',
      category: RiskCategory.apoio,
      text: 'Você sente que NÃO tem uma rede de apoio para recorrer?',
      options: _padrao,
    ),
  ];

  @override
  Future<List<QuestionModel>> fetchQuestions() async {
    // Simula latência de rede para exibir os estados de loading da UI.
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _bank;
  }

  @override
  Future<RiskResult> evaluate(Map<String, String> answers) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    // Converte (questionId -> optionId) em (questionId -> AnswerOption).
    final byId = {for (final q in _bank) q.id: q};
    final selected = <String, AnswerOption>{};
    answers.forEach((qid, optId) {
      final q = byId[qid];
      if (q != null) {
        selected[qid] = q.options.firstWhere(
          (o) => o.id == optId,
          orElse: () => q.options.last,
        );
      }
    });

    return calculator.calculate(questions: _bank, answers: selected);
  }
}
