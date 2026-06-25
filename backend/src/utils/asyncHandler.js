/**
 * Envolve handlers async para encaminhar rejeições ao errorHandler do Express,
 * evitando try/catch repetido em todos os controllers.
 */
export const asyncHandler = (fn) => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next);
