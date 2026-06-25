import '../error/failures.dart';

/// Tipo de retorno funcional usado entre as camadas (Data → Domain → UI).
///
/// Em vez de lançar exceções pela aplicação inteira, repositórios e usecases
/// retornam um [Result]: ou [Ok] (sucesso, com valor) ou [Err] (falha de
/// domínio). Isso torna o tratamento de erro EXPLÍCITO e testável, sem
/// depender de pacotes externos (ex.: dartz).
sealed class Result<T> {
  const Result();

  /// Reduz os dois casos a um único valor — força o tratamento do erro.
  R fold<R>(R Function(Failure failure) onErr, R Function(T value) onOk) {
    final self = this;
    return switch (self) {
      Ok<T>() => onOk(self.value),
      Err<T>() => onErr(self.failure),
    };
  }

  bool get isOk => this is Ok<T>;
}

class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}

/// Açúcar sintático para assinaturas de repositórios/usecases.
typedef ResultFuture<T> = Future<Result<T>>;
