import { reportRepository } from '../repositories/report.repository.js';

export const reportService = {
  create: (data) => reportRepository.create(data),
  list: () => reportRepository.list(),
};
