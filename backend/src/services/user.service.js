import { userRepository } from '../repositories/user.repository.js';
import { AppError } from '../utils/AppError.js';

export const userService = {
  list: () => userRepository.list(),

  async getById(id) {
    const user = await userRepository.findById(id);
    if (!user) throw new AppError('Usuário não encontrado.', 404);
    return user;
  },
};
