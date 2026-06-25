import { questionService } from '../services/question.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const questionController = {
  list: asyncHandler(async (_req, res) => {
    res.json(await questionService.getQuestions());
  }),
};
