import { AppError } from '../utils/AppError.js';

/** Captura rotas inexistentes e delega ao errorHandler como 404. */
export const notFound = (req, _res, next) =>
  next(new AppError(`Rota não encontrada: ${req.method} ${req.originalUrl}`, 404));
