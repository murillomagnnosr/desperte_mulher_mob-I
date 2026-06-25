import { query } from '../database/pool.js';

export const contactRepository = {
  async create(d) {
    const { rows } = await query(
      `INSERT INTO contacts (name, email, message)
       VALUES ($1, $2, $3) RETURNING id, created_at`,
      [d.name, d.email, d.message],
    );
    return rows[0];
  },
};
