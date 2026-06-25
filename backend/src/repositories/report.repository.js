import { query } from '../database/pool.js';

export const reportRepository = {
  async create(d) {
    const { rows } = await query(
      `INSERT INTO reports (violence_type, municipality, address, reference_point, description)
       VALUES ($1, $2, $3, $4, $5) RETURNING id, created_at`,
      [d.violenceType, d.municipality, d.address ?? null, d.referencePoint ?? null, d.description],
    );
    return rows[0];
  },

  async list() {
    const { rows } = await query(
      'SELECT * FROM reports ORDER BY created_at DESC LIMIT 200',
    );
    return rows;
  },
};
