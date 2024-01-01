import {Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {WeightHistoryEntity} from "../../entities/weight-history.entity";

@Injectable()
export class WeightHistoryService {
    constructor(
        @Inject('WEIGHT_HISTORY_REPOSITORY')
        private readonly weightHistoryRepository: Repository<WeightHistoryEntity>
    ) {
    }

    async getWeightHistory(user) {
        return this.weightHistoryRepository
            .createQueryBuilder('weight_history')
            .where('weight_history.userId = :userId', {userId: user.id})
            .addOrderBy('weight_history.createdAt', 'DESC')
            .getMany();
    }
}
