import { Router } from 'express';

import { contactController } from '../controllers/contact.controller.js';
import { validate } from '../middlewares/validate.js';
import { createContactSchema } from '../validators/contact.validator.js';

const router = Router();

router.post('/', validate(createContactSchema), contactController.create);

export default router;
