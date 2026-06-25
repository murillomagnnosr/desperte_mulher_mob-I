import bcrypt from 'bcryptjs';

import { userRepository } from '../repositories/user.repository.js';
import { AppError } from '../utils/AppError.js';
import {
  signAccessToken,
  signRefreshToken,
  verifyRefreshToken,
} from '../utils/jwt.js';

function buildTokens(user) {
  const payload = { sub: user.id, role: user.role };
  return {
    accessToken: signAccessToken(payload),
    refreshToken: signRefreshToken(payload),
  };
}

export const authService = {
  async register({ name, email, password }) {
    const existing = await userRepository.findByEmail(email);
    if (existing) throw new AppError('E-mail já cadastrado.', 409);
    // BCrypt: hash com salt (custo 10). A senha em texto nunca é persistida.
    const passwordHash = await bcrypt.hash(password, 10);
    return userRepository.create({
      roleName: 'atendente',
      name,
      email,
      passwordHash,
    });
  },

  async login({ email, password }) {
    const user = await userRepository.findByEmail(email);
    if (!user) throw new AppError('Credenciais inválidas.', 401);

    const ok = await bcrypt.compare(password, user.password_hash);
    if (!ok) throw new AppError('Credenciais inválidas.', 401);
    if (!user.is_active) throw new AppError('Usuário inativo.', 403);

    return {
      user: { id: user.id, name: user.name, email: user.email, role: user.role },
      ...buildTokens(user),
    };
  },

  refresh(refreshToken) {
    try {
      const payload = verifyRefreshToken(refreshToken);
      return buildTokens({ id: payload.sub, role: payload.role });
    } catch {
      throw new AppError('Refresh token inválido ou expirado.', 401);
    }
  },
};
