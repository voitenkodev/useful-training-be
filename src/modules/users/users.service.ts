import { Inject, Injectable } from '@nestjs/common';
import { UsersEntity } from '../../entities/users.entity';
import { Repository } from 'typeorm';

@Injectable()
export class UsersService {
  constructor(
    @Inject('USERS_REPOSITORY')
    private readonly usersRepository: Repository<UsersEntity>,
  ) {}

  async getAllUsers() {
    return this.usersRepository
      .createQueryBuilder('users')
      .select(['users.id', 'users.email', 'users.createdAt', 'users.updatedAt'])
      .addOrderBy('users.createdAt', 'DESC')
      .getMany();
  }
}
