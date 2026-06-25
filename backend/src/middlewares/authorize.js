import { AppError } from '../utils/AppError.js';

/**
 * Autorização baseada em papéis (RBAC). Use após `authenticate`.
 * Ex.: router.get('/users', authenticate, authorize('admin'), handler)
 */
export const authorize = (...roles) => (req, _res, next) => {
  if (!req.user) throw new AppError('Não autenticado.', 401);
  if (roles.length > 0 && !roles.includes(req.user.role)) {
    throw new AppError('Você não tem permissão para esta ação.', 403);
  }
  next();
};
