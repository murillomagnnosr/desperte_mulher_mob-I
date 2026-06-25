import 'package:equatable/equatable.dart';

/// Representa um erro de DOMÍNIO (não exceções de infraestrutura).
///
/// Padrão Clean Architecture: a camada de dados captura exceções (Dio,
/// parsing, etc.) e as converte em [Failure]. Os UseCases e a UI lidam
/// apenas com Failures — desacoplando regras de negócio de detalhes técnicos.
sealed class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

/// Falha de rede (timeout, sem conexão).
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sem conexão com o servidor.']);
}

/// Erro retornado pelo servidor (4xx/5xx).
class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Falha de autenticação/autorização (401/403).
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Sessão expirada. Faça login novamente.']);
}

/// Erro de validação de dados (entrada inválida).
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {this.fieldErrors = const {}});
  final Map<String, String> fieldErrors;

  @override
  List<Object?> get props => [message, fieldErrors];
}

/// Falha inesperada (fallback).
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Ocorreu um erro inesperado.']);
}
