import {Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {UserWeightsEntity} from "../../entities/user-weights.entity";

@Injectable()
export class UserWeightsService {
    constructor(
        @Inject('USER_WEIGHTS_REPOSITORY')
        private readonly userWeightsRepository: Repository<UserWeightsEntity>
    ) {
    }

    async getUserWeights(user) {
        return this.userWeightsRepository
            .createQueryBuilder('user_weights')
            .where('user_weights.userId = :userId', {userId: user.id})
            .addOrderBy('user_weights.createdAt', 'DESC')
            .getMany();
    }
}
