import { contactRepository } from '../repositories/contact.repository.js';

export const contactService = {
  create: (data) => contactRepository.create(data),
};
