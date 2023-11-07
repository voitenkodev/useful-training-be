import {Inject, Injectable} from '@nestjs/common';
import {UsersEntity} from '../../entities/users.entity';
import {Repository} from 'typeorm';

@Injectable()
export class UsersService {
    constructor(
        @Inject('USERS_REPOSITORY')
        private readonly usersRepository: Repository<UsersEntity>
    ) {
    }

    async getAllUsers() {
        return this.usersRepository
            .createQueryBuilder('users')
            .select(['users.id', 'users.email', 'users.name', 'users.weight', 'users.height', 'users.createdAt', 'users.updatedAt'])
            .addOrderBy('users.createdAt', 'DESC')
            .getMany();
    }

    async getUser(id: string) {
        return this.usersRepository
            .createQueryBuilder('users')
            .where('users.id = :id', {id})
            .select(['users.id', 'users.email', 'users.name', 'users.weight', 'users.height', 'users.createdAt', 'users.updatedAt'])
            .getOne();
    }
}
