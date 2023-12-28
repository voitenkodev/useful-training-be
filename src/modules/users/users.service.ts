import {Inject, Injectable} from '@nestjs/common';
import {UsersEntity} from '../../entities/users.entity';
import {Repository} from 'typeorm';
import {UserWeightsEntity} from "../../entities/user-weights.entity";

@Injectable()
export class UsersService {
    constructor(
        @Inject('USERS_REPOSITORY')
        private readonly usersRepository: Repository<UsersEntity>,
        @Inject('USER_WEIGHTS_REPOSITORY')
        private readonly userWeightsRepository: Repository<UserWeightsEntity>
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
        const user = await this.usersRepository
            .createQueryBuilder('users')
            .where('users.id = :id', {id})
            .select(['users.id', 'users.email', 'users.name', 'users.height', 'users.createdAt', 'users.updatedAt'])
            .getOne();

        const weightData = await this.userWeightsRepository
            .createQueryBuilder("weights")
            .where('weights.userId = :userId', {userId: user.id})
            .orderBy('weights.createdAt', 'DESC')
            .select(['weights.id', 'weights.weight'])
            .getOne();

        return {
            ...user,
            weight: weightData.weight
        }
    }
}
