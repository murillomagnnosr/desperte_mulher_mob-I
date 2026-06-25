import { Router } from 'express';

import { answerController } from '../controllers/answer.controller.js';
import { validate } from '../middlewares/validate.js';
import { submitAnswersSchema } from '../validators/answer.validator.js';

const router = Router();

// Público e anônimo: envia respostas e recebe o resultado classificado.
router.post('/', validate(submitAnswersSchema), answerController.submit);

export default router;
