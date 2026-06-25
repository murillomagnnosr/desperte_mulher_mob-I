import { Router } from 'express';

import answerRoutes from './answer.routes.js';
import authRoutes from './auth.routes.js';
import contactRoutes from './contact.routes.js';
import questionRoutes from './question.routes.js';
import reportRoutes from './report.routes.js';
import userRoutes from './user.routes.js';

/** Agrega todas as rotas sob /api/v1. */
export const routes = Router();

routes.use('/auth', authRoutes);
routes.use('/users', userRoutes);
routes.use('/questions', questionRoutes);
routes.use('/answers', answerRoutes);
routes.use('/reports', reportRoutes);
routes.use('/contacts', contactRoutes);
