import { z } from 'zod';

export const createContactSchema = z.object({
  name: z.string().min(2, 'Informe seu nome.'),
  email: z.string().email('E-mail inválido.'),
  message: z.string().min(5, 'Escreva sua mensagem.'),
});
