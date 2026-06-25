/**
 * Erro de aplicação com status HTTP. Lançado pelas camadas de
 * service/repository e tratado de forma central pelo errorHandler.
 */
export class AppError extends Error {
  constructor(message, statusCode = 400, details = undefined) {
    super(message);
    this.name = 'AppError';
    this.statusCode = statusCode;
    this.details = details;
    this.isOperational = true;
  }
}
