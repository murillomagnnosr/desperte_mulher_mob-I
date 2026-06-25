import { AppError } from '../utils/AppError.js';
import { verifyAccessToken } from '../utils/jwt.js';

/**
 * Exige um Bearer token válido. Em caso de sucesso, anexa `req.user`
 * ({ sub, role }) para os middlewares/controllers seguintes.
 */
export const authenticate = (req, _res, next) => {
  const header = req.headers.authorization;
  if (!header || !header.startsWith('Bearer ')) {
    throw new AppError('Token de autenticação ausente.', 401);
  }
  try {
    req.user = verifyAccessToken(header.slice(7));
    next();
  } catch {
    throw new AppError('Token inválido ou expirado.', 401);
  }
};
