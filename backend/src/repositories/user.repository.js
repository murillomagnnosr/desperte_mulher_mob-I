import { query } from '../database/pool.js';

/** Acesso a dados de usuários. Sempre usa SQL parametrizado. */
export const userRepository = {
  async findByEmail(email) {
    const { rows } = await query(
      `SELECT u.*, r.name AS role
         FROM users u JOIN roles r ON r.id = u.role_id
        WHERE u.email = $1`,
      [email],
    );
    return rows[0] ?? null;
  },

  async findById(id) {
    const { rows } = await query(
      `SELECT u.id, u.name, u.email, u.phone, u.is_active, r.name AS role
         FROM users u JOIN roles r ON r.id = u.role_id
        WHERE u.id = $1`,
      [id],
    );
    return rows[0] ?? null;
  },

  async create({ roleName, name, email, passwordHash, phone }) {
    const { rows } = await query(
      `INSERT INTO users (role_id, name, email, password_hash, phone)
       SELECT id, $2, $3, $4, $5 FROM roles WHERE name = $1
       RETURNING id, name, email`,
      [roleName, name, email, passwordHash, phone ?? null],
    );
    return rows[0];
  },

  async list() {
    const { rows } = await query(
      `SELECT u.id, u.name, u.email, r.name AS role, u.is_active, u.created_at
         FROM users u JOIN roles r ON r.id = u.role_id
        ORDER BY u.created_at DESC`,
    );
    return rows;
  },
};
