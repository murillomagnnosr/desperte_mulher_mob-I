import { contactService } from '../services/contact.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const contactController = {
  create: asyncHandler(async (req, res) => {
    res.status(201).json(await contactService.create(req.body));
  }),
};
