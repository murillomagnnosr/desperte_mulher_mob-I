import { auditRepository } from '../repositories/audit.repository.js';
import { reportService } from '../services/report.service.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const reportController = {
  // Denúncia anônima (rota pública).
  create: asyncHandler(async (req, res) => {
    const report = await reportService.create(req.body);
    await auditRepository.log({
      action: 'CREATE_REPORT',
      entity: 'report',
      entityId: report.id,
      ip: req.ip,
    });
    res.status(201).json(report);
  }),

  // Listagem restrita à área Acolhe.
  list: asyncHandler(async (_req, res) => {
    res.json(await reportService.list());
  }),
};
