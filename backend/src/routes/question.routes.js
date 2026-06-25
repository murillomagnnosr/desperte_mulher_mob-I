import { Router } from 'express';

import { questionController } from '../controllers/question.controller.js';

const router = Router();

// Público: o questionário é acessível sem login (anonimato).
router.get('/', questionController.list);

export default router;
