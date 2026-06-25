import { query } from '../database/pool.js';

export const questionRepository = {
  /** Perguntas ativas com suas opções aninhadas (ordenadas). */
  async findAllActive() {
    const { rows } = await query(
      `SELECT q.id, q.category, q.text, q.position,
              COALESCE(
                json_agg(
                  json_build_object('id', o.id, 'label', o.label, 'score', o.score)
                  ORDER BY o.score DESC
                ) FILTER (WHERE o.id IS NOT NULL), '[]'
              ) AS options
         FROM questions q
         LEFT JOIN answer_options o ON o.question_id = q.id
        WHERE q.is_active = true
        GROUP BY q.id
        ORDER BY q.position`,
    );
    return rows;
  },

  /** Mapa simples de opções (id, question_id, score) para o cálculo. */
  async findOptions() {
    const { rows } = await query(
      'SELECT id, question_id, score FROM answer_options',
    );
    return rows;
  },
};
