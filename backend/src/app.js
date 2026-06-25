import cors from 'cors';
import express from 'express';
import rateLimit from 'express-rate-limit';
import helmet from 'helmet';
import morgan from 'morgan';

import { env } from './config/env.js';
import { errorHandler } from './middlewares/errorHandler.js';
import { notFound } from './middlewares/notFound.js';
import { routes } from './routes/index.js';

/**
 * Monta a aplicação Express com a pilha de segurança (Etapa 14):
 *  - helmet: cabeçalhos HTTP seguros (mitiga XSS/clickjacking).
 *  - cors: restringe as origens permitidas.
 *  - express.json: parser com limite de tamanho (evita payloads enormes).
 *  - rateLimit: mitiga brute force / abuso.
 *  - rotas /api/v1, depois 404 e o tratador de erros central.
 */
export function createApp() {
  const app = express();

  app.use(helmet());
  app.use(cors({ origin: env.corsOrigins, credentials: true }));
  app.use(express.json({ limit: '1mb' }));
  if (!env.isProduction) app.use(morgan('dev'));

  app.use(
    rateLimit({
      windowMs: 15 * 60 * 1000,
      max: 300,
      standardHeaders: true,
      legacyHeaders: false,
    }),
  );

  app.get('/health', (_req, res) => res.json({ status: 'ok', service: 'desperte-mulher-api' }));

  app.use('/api/v1', routes);

  app.use(notFound);
  app.use(errorHandler);

  return app;
}
