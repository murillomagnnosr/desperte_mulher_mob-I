import bcrypt from 'bcryptjs';

import { pool } from './pool.js';

/**
 * Popula dados iniciais: papéis, um usuário admin e o questionário de risco.
 * As perguntas/pesos espelham o mock do frontend — devem ser substituídos
 * pelo instrumento científico validado. Uso: `npm run seed`.
 */
const QUESTIONS = [
  ['violencia', 'Você já sofreu agressão física por parte do(a) parceiro(a)?'],
  ['violencia', 'Você recebe ameaças ou é humilhada com frequência?'],
  ['controle', 'Seu dinheiro, documentos ou saídas são controlados por ele(a)?'],
  ['controle', 'Você foi afastada de familiares e amigos (isolamento)?'],
  ['escalada', 'Ele(a) tem acesso a armas de fogo?'],
  ['escalada', 'As agressões têm ficado mais frequentes ou intensas?'],
  ['dependentes', 'Há crianças ou dependentes expostos à violência?'],
  ['apoio', 'Você sente que NÃO tem uma rede de apoio para recorrer?'],
];

const OPTIONS = [
  ['Sim', 2],
  ['Às vezes', 1],
  ['Não', 0],
];

async function seed() {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // Papéis
    await client.query(`
      INSERT INTO roles (name, description) VALUES
        ('admin', 'Administrador do sistema'),
        ('atendente', 'Atendente da rede de apoio'),
        ('parceiro', 'Instituição parceira')
      ON CONFLICT (name) DO NOTHING;`);

    // Usuário admin
    const hash = await bcrypt.hash('Admin@123', 10);
    await client.query(
      `INSERT INTO users (role_id, name, email, password_hash)
       SELECT id, 'Administrador', 'admin@despertemulher.org', $1
       FROM roles WHERE name = 'admin'
       ON CONFLICT (email) DO NOTHING;`,
      [hash],
    );

    // Perguntas + opções (evita duplicar em re-execução)
    const { rows } = await client.query('SELECT COUNT(*)::int AS n FROM questions');
    if (rows[0].n === 0) {
      for (let i = 0; i < QUESTIONS.length; i++) {
        const [category, text] = QUESTIONS[i];
        const q = await client.query(
          `INSERT INTO questions (category, text, position)
           VALUES ($1, $2, $3) RETURNING id;`,
          [category, text, i],
        );
        for (const [label, score] of OPTIONS) {
          await client.query(
            `INSERT INTO answer_options (question_id, label, score)
             VALUES ($1, $2, $3);`,
            [q.rows[0].id, label, score],
          );
        }
      }
    }

    await client.query('COMMIT');
    console.log('✔ Seed concluído (admin: admin@despertemulher.org / Admin@123).');
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('✖ Falha no seed:', err.message);
    process.exitCode = 1;
  } finally {
    client.release();
    await pool.end();
  }
}

seed();
