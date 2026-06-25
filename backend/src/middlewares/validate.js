import { AppError } from '../utils/AppError.js';

/**
 * Middleware de validação de entrada usando um schema Zod.
 * Em caso de erro, responde 422 com o mapa campo -> mensagem.
 * Também SANITIZA: `req.body` passa a conter apenas os dados validados.
 */
export const validate = (schema) => (req, _res, next) => {
  const result = schema.safeParse(req.body);
  if (!result.success) {
    const details = {};
    for (const issue of result.error.issues) {
      details[issue.path.join('.') || '_'] = issue.message;
    }
    throw new AppError('Dados inválidos.', 422, details);
  }
  req.body = result.data;
  next();
};
