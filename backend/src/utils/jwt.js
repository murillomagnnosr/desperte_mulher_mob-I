import jwt from 'jsonwebtoken';

import { env } from '../config/env.js';

/**
 * Geração e verificação de tokens JWT.
 * - Access token: curta duração (15m) — usado nas requisições.
 * - Refresh token: longa duração (7d) — renova o access sem novo login.
 */
export const signAccessToken = (payload) =>
  jwt.sign(payload, env.jwt.accessSecret, { expiresIn: env.jwt.accessExpires });

export const signRefreshToken = (payload) =>
  jwt.sign(payload, env.jwt.refreshSecret, { expiresIn: env.jwt.refreshExpires });

export const verifyAccessToken = (token) =>
  jwt.verify(token, env.jwt.accessSecret);

export const verifyRefreshToken = (token) =>
  jwt.verify(token, env.jwt.refreshSecret);
