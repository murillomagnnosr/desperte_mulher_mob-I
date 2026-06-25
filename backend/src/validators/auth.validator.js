import { z } from 'zod';

export const registerSchema = z.object({
  name: z.string().min(2, 'Nome muito curto.'),
  email: z.string().email('E-mail inválido.'),
  password: z.string().min(6, 'A senha deve ter ao menos 6 caracteres.'),
});

export const loginSchema = z.object({
  email: z.string().email('E-mail inválido.'),
  password: z.string().min(1, 'Informe a senha.'),
});

export const refreshSchema = z.object({
  refreshToken: z.string().min(10, 'Refresh token inválido.'),
});
