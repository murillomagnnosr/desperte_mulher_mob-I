import { pool } from '../database/pool.js';

export const resultRepository = {
  /**
   * Salva o resultado e suas respostas em uma TRANSAÇÃO (atomicidade):
   * ou tudo é gravado, ou nada. `userId` pode ser null (análise anônima).
   */
  async save({ userId, percent, level, answers }) {
    const client = await pool.connect();
    try {
      await client.query('BEGIN');
      const r = await client.query(
        `INSERT INTO results (user_id, percent, level)
         VALUES ($1, $2, $3) RETURNING id, created_at`,
        [userId ?? null, percent, level],
      );
      const resultId = r.rows[0].id;
      for (const a of answers) {
        await client.query(
          `INSERT INTO answers (result_id, question_id, answer_option_id, score)
           VALUES ($1, $2, $3, $4)`,
          [resultId, a.questionId, a.optionId, a.score],
        );
      }
      await client.query('COMMIT');
      return { id: resultId, createdAt: r.rows[0].created_at };
    } catch (err) {
      await client.query('ROLLBACK');
      throw err;
    } finally {
      client.release();
    }
  },
};
