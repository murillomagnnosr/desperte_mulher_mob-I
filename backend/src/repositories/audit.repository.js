import { query } from '../database/pool.js';

export const auditRepository = {
  /** Registra uma ação sensível na trilha de auditoria. Nunca lança ao chamador. */
  async log({ userId, action, entity, entityId, ip }) {
    try {
      await query(
        `INSERT INTO audit_logs (user_id, action, entity, entity_id, ip_address)
         VALUES ($1, $2, $3, $4, $5)`,
        [userId ?? null, action, entity ?? null, entityId ?? null, ip ?? null],
      );
    } catch (err) {
      console.error('[AUDIT] falha ao registrar log:', err.message);
    }
  },
};
