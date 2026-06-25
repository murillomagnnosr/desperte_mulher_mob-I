import { z } from 'zod';

/** { answers: { [questionId]: optionId } } */
export const submitAnswersSchema = z.object({
  answers: z
    .record(z.string(), z.string())
    .refine((obj) => Object.keys(obj).length > 0, {
      message: 'Responda ao menos uma pergunta.',
    }),
});
