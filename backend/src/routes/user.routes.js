import { Router } from 'express';

import { userController } from '../controllers/user.controller.js';
import { authenticate } from '../middlewares/authenticate.js';
import { authorize } from '../middlewares/authorize.js';

const router = Router();

// Apenas administradores listam usuários.
router.get('/', authenticate, authorize('admin'), userController.list);

export default router;
