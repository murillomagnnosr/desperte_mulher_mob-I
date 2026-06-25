import { questionRepository } from '../repositories/question.repository.js';

export const questionService = {
  getQuestions: () => questionRepository.findAllActive(),
};
