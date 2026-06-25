import '../../../../core/utils/result.dart';
import '../entities/question.dart';
import '../repositories/analise_repository.dart';

/// UseCase: obter o questionário de risco.
///
/// Cada UseCase representa UMA ação de negócio (princípio da responsabilidade
/// única). É um objeto "callable" — invocado como `getQuestions()`.
class GetQuestions {
  const GetQuestions(this._repository);
  final AnaliseRepository _repository;

  ResultFuture<List<Question>> call() => _repository.getQuestions();
}
