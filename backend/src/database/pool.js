import pg from 'pg';

import { env } from '../config/env.js';

/**
 * Pool de conexões PostgreSQL (reutiliza conexões — eficiente e seguro).
 * Toda query parametrizada ($1, $2...) passa por aqui, o que previne
 * SQL Injection (os valores nunca são concatenados na string SQL).
 */
export const pool = new pg.Pool({
  connectionString: env.databaseUrl,
  ssl: env.pgSsl ? { rejectUnauthorized: false } : false,
});

export const query = (text, params) => pool.query(text, params);
