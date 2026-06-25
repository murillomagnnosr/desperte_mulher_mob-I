import { answerService } from '../services/answer.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const answerController = {
  // Rota pública: análise pode ser anônima (req.user ausente => userId null).
  submit: asyncHandler(async (req, res) => {
    const userId = req.user?.sub;
    const result = await answerService.evaluate({
      answers: req.body.answers,
      userId,
    });
    res.status(201).json(result);
  }),
};
