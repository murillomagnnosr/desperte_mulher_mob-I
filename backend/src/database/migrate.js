import { readFile } from 'node:fs/promises';

import { pool } from './pool.js';

/**
 * Migração simples: executa o schema.sql (idempotente — usa IF NOT EXISTS).
 * Uso: `npm run migrate`.
 */
async function migrate() {
  const sql = await readFile(new URL('./schema.sql', import.meta.url), 'utf8');
  console.log('Aplicando schema...');
  await pool.query(sql);
  console.log('✔ Schema aplicado com sucesso.');
  await pool.end();
}

migrate().catch((err) => {
  console.error('✖ Falha na migração:', err.message);
  process.exit(1);
});
