import { auditRepository } from '../repositories/audit.repository.js';
import { authService } from '../services/auth.service.js';
import { userService } from '../services/user.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const authController = {
  register: asyncHandler(async (req, res) => {
    const user = await authService.register(req.body);
    res.status(201).json(user);
  }),

  login: asyncHandler(async (req, res) => {
    const data = await authService.login(req.body);
    await auditRepository.log({ userId: data.user.id, action: 'LOGIN', ip: req.ip });
    res.json(data);
  }),

  refresh: asyncHandler(async (req, res) => {
    res.json(authService.refresh(req.body.refreshToken));
  }),

  me: asyncHandler(async (req, res) => {
    res.json(await userService.getById(req.user.sub));
  }),
};
