import dotenv from 'dotenv';

dotenv.config();

/**
 * Configuração central da aplicação, lida do ambiente (.env).
 * Centralizar aqui evita `process.env` espalhado pelo código.
 */
export const env = {
  port: Number(process.env.PORT ?? 3333),
  nodeEnv: process.env.NODE_ENV ?? 'development',
  isProduction: process.env.NODE_ENV === 'production',

  databaseUrl:
    process.env.DATABASE_URL ??
    'postgresql://postgres:postgres@localhost:5432/desperte_mulher',
  pgSsl: process.env.PGSSL === 'true',

  jwt: {
    accessSecret: process.env.JWT_ACCESS_SECRET ?? 'dev-access-secret',
    refreshSecret: process.env.JWT_REFRESH_SECRET ?? 'dev-refresh-secret',
    accessExpires: process.env.JWT_ACCESS_EXPIRES ?? '15m',
    refreshExpires: process.env.JWT_REFRESH_EXPIRES ?? '7d',
  },

  corsOrigins: (process.env.CORS_ORIGINS ?? 'http://localhost:5000')
    .split(',')
    .map((o) => o.trim()),
};
