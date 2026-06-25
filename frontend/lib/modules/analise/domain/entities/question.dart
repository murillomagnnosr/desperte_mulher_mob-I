import 'package:equatable/equatable.dart';

/// Categorias avaliadas pelo questionário (conforme o site original).
/// NÃO altera a lógica: apenas nomeia os grupos de fatores de risco.
enum RiskCategory {
  violencia, // histórico de violência física/psicológica/ameaças
  controle, // controle financeiro, isolamento, monitoramento
  escalada, // acesso a armas e escalada de comportamentos
  dependentes, // vulnerabilidade de crianças/dependentes
  apoio; // rede de apoio, moradia e renda

  String get titulo => switch (this) {
        RiskCategory.violencia => 'Histórico de violência',
        RiskCategory.controle => 'Controle e isolamento',
        RiskCategory.escalada => 'Escalada e acesso a armas',
        RiskCategory.dependentes => 'Crianças e dependentes',
        RiskCategory.apoio => 'Rede de apoio e condições',
      };
}

/// Uma opção de resposta com seu peso (pontuação) na avaliação.
class AnswerOption extends Equatable {
  const AnswerOption({
    required this.id,
    required this.label,
    required this.score,
  });

  final String id;
  final String label;

  /// Pontos que esta opção adiciona ao risco (0 = sem risco).
  final double score;

  @override
  List<Object?> get props => [id, label, score];
}

/// Uma pergunta do questionário de risco.
///
/// O conteúdo (texto/opções/pesos) é DADO, vindo do datasource — assim o
/// instrumento validado pela metodologia científica pode ser plugado sem
/// tocar no código. O `maxScore` permite normalizar para 0..100%.
class Question extends Equatable {
  const Question({
    required this.id,
    required this.category,
    required this.text,
    required this.options,
  });

  final String id;
  final RiskCategory category;
  final String text;
  final List<AnswerOption> options;

  /// Maior pontuação possível desta pergunta (para normalização).
  double get maxScore =>
      options.map((o) => o.score).fold(0, (a, b) => a > b ? a : b);

  @override
  List<Object?> get props => [id, category, text, options];
}
