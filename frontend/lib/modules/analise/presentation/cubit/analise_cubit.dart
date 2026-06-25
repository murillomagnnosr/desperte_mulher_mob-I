import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/question.dart';
import '../../domain/entities/risk_result.dart';
import '../../domain/usecases/get_questions.dart';
import '../../domain/usecases/submit_assessment.dart';

part 'analise_state.dart';

/// Cubit que conduz o questionário de risco.
///
/// Recebe os UseCases por injeção (não conhece repositórios nem Dio). Toda
/// interação da UI vira um método aqui, que emite um novo [AnaliseState].
class AnaliseCubit extends Cubit<AnaliseState> {
  AnaliseCubit({
    required GetQuestions getQuestions,
    required SubmitAssessment submitAssessment,
  })  : _getQuestions = getQuestions,
        _submitAssessment = submitAssessment,
        super(const AnaliseState());

  final GetQuestions _getQuestions;
  final SubmitAssessment _submitAssessment;

  /// Carrega o questionário ao abrir a tela.
  Future<void> load() async {
    emit(state.copyWith(status: AnaliseStatus.loading));
    final result = await _getQuestions();
    result.fold(
      (failure) => emit(state.copyWith(
        status: AnaliseStatus.failure,
        errorMessage: failure.message,
      ),),
      (questions) => emit(state.copyWith(
        status: AnaliseStatus.ready,
        questions: questions,
        currentIndex: 0,
        answers: const {},
      ),),
    );
  }

  /// Registra a resposta da pergunta atual.
  void answer(String questionId, String optionId) {
    final updated = Map<String, String>.from(state.answers)
      ..[questionId] = optionId;
    emit(state.copyWith(answers: updated));
  }

  void next() {
    if (!state.isLastQuestion) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void previous() {
    if (!state.isFirstQuestion) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  /// Submete as respostas e calcula o resultado.
  Future<void> submit() async {
    emit(state.copyWith(status: AnaliseStatus.submitting));
    final result = await _submitAssessment(state.answers);
    result.fold(
      (failure) => emit(state.copyWith(
        status: AnaliseStatus.failure,
        errorMessage: failure.message,
      ),),
      (risk) => emit(state.copyWith(
        status: AnaliseStatus.success,
        result: risk,
      ),),
    );
  }

  void reset() => emit(const AnaliseState());
}
