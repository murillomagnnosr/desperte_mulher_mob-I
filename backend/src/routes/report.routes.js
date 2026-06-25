import { Router } from 'express';

import { reportController } from '../controllers/report.controller.js';
import { authenticate } from '../middlewares/authenticate.js';
import { authorize } from '../middlewares/authorize.js';
import { validate } from '../middlewares/validate.js';
import { createReportSchema } from '../validators/report.validator.js';

const router = Router();

// Criar denúncia: público e anônimo.
router.post('/', validate(createReportSchema), reportController.create);

// Listar denúncias: restrito à rede (admin/atendente).
router.get('/', authenticate, authorize('admin', 'atendente'), reportController.list);

export default router;
