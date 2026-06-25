import { z } from 'zod';

export const createReportSchema = z.object({
  violenceType: z.string().min(2, 'Informe o tipo de violência.'),
  municipality: z.string().min(2, 'Informe o município.'),
  address: z.string().optional(),
  referencePoint: z.string().optional(),
  description: z.string().min(10, 'Descreva o ocorrido.'),
});
