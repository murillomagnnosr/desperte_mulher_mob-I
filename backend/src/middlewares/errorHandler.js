import { env } from '../config/env.js';

/**
 * Tratamento de erros centralizado (último middleware).
 * Converte qualquer erro em uma resposta JSON consistente, sem vazar detalhes
 * internos em produção.
 */
// eslint-disable-next-line no-unused-vars
export const errorHandler = (err, req, res, next) => {
  const status = err.statusCode ?? 500;
  const body = { error: err.message ?? 'Erro interno do servidor.' };
  if (err.details) body.details = err.details;

  if (status >= 500) {
    console.error('[ERRO]', err);
    if (!env.isProduction) body.stack = err.stack;
  }

  res.status(status).json(body);
};
