part of 'analise_cubit.dart';

enum AnaliseStatus { initial, loading, ready, submitting, success, failure }

/// Estado imutável do fluxo de Análise de Risco.
///
/// Um único objeto descreve toda a tela: status, perguntas, posição no
/// questionário, respostas dadas e (ao final) o resultado. A UI é função
/// pura deste estado.
class AnaliseState extends Equatable {
  const AnaliseState({
    this.status = AnaliseStatus.initial,
    this.questions = const [],
    this.currentIndex = 0,
    this.answers = const {},
    this.result,
    this.errorMessage,
  });

  final AnaliseStatus status;
  final List<Question> questions;
  final int currentIndex;
  final Map<String, String> answers; // questionId -> optionId
  final RiskResult? result;
  final String? errorMessage;

  Question? get currentQuestion =>
      questions.isEmpty ? null : questions[currentIndex];

  bool get isLastQuestion => currentIndex >= questions.length - 1;

  bool get isFirstQuestion => currentIndex == 0;

  /// Progresso 0..1 para a barra.
  double get progress =>
      questions.isEmpty ? 0 : (currentIndex + 1) / questions.length;

  /// A pergunta atual já foi respondida?
  bool get currentAnswered =>
      currentQuestion != null && answers.containsKey(currentQuestion!.id);

  /// Todas as perguntas foram respondidas?
  bool get allAnswered =>
      questions.isNotEmpty && answers.length == questions.length;

  AnaliseState copyWith({
    AnaliseStatus? status,
    List<Question>? questions,
    int? currentIndex,
    Map<String, String>? answers,
    RiskResult? result,
    String? errorMessage,
  }) {
    return AnaliseState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      result: result ?? this.result,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, questions, currentIndex, answers, result, errorMessage];
}
