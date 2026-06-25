import { userService } from '../services/user.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const userController = {
  list: asyncHandler(async (_req, res) => {
    res.json(await userService.list());
  }),
};
