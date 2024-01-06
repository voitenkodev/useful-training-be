import {Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {MusclesEntity} from "../../entities/muscles.entity";
import {MuscleTypesEntity} from "../../entities/muscle-types.entity";
import {MuscleResponse, MuscleTypeResponse} from "./dto/muscle-response";
import {MuscleStatusEnum} from "../../lib/muscle-status.enum";
import {ExcludedMusclesEntity} from "../../entities/excluded-muscles.entity";

@Injectable()
export class MusclesService {
    constructor(
        @Inject('MUSCLES_REPOSITORY')
        private readonly musclesRepository: Repository<MusclesEntity>,
        @Inject('MUSCLE_TYPES_REPOSITORY')
        private readonly muscleTypeRepository: Repository<MuscleTypesEntity>,
        @Inject('EXCLUDED_MUSCLES_REPOSITORY')
        private readonly excludedMusclesEntity: Repository<ExcludedMusclesEntity>
    ) {
    }

    async getUserMuscles(user) {
        const muscleTypes = await this.muscleTypeRepository
            .createQueryBuilder('muscle_types')
            .leftJoinAndSelect('muscle_types.muscles', 'muscles')
            .getMany();

        const excluded = await this.excludedMusclesEntity
            .createQueryBuilder('excluded_muscles')
            .where('excluded_muscles.userId = :userId', {userId: user.id})
            .select(['excluded_muscles.muscleId'])
            .getMany();

        return muscleTypes.map((item) => {
                const muscleType = new MuscleTypeResponse()
                muscleType.id = item.id
                muscleType.name = item.name
                muscleType.type = item.type
                muscleType.createdAt = item.createdAt
                muscleType.updatedAt = item.updatedAt
                muscleType.muscles = item.muscles.map((muscle) => {
                        return this.processingMuscle(user, muscle, excluded)
                    }
                )
                return muscleType
            }
        )
    }

    async getMuscleById(user, id: string) {
        const muscle: MusclesEntity = await this.musclesRepository
            .createQueryBuilder('muscles')
            .where('muscles.id = :id', {id})
            .getOne();

        const excluded = await this.excludedMusclesEntity
            .createQueryBuilder('excluded_muscles')
            .where('excluded_muscles.userId = :userId', {userId: user.id})
            .select(['excluded_muscles.muscleId'])
            .getMany();

        return this.processingMuscle(user, muscle, excluded)
    }

    async getPublicMuscles() {
        const muscleTypes = await this.muscleTypeRepository
            .createQueryBuilder('muscle_types')
            .leftJoinAndSelect('muscle_types.muscles', 'muscles')
            .getMany();

        return muscleTypes.map((item) => {
                const muscleType = new MuscleTypeResponse()
                muscleType.id = item.id
                muscleType.name = item.name
                muscleType.type = item.type
                muscleType.createdAt = item.createdAt
                muscleType.updatedAt = item.updatedAt
                muscleType.muscles = item.muscles.map((muscle) => {
                        const muscleResponse = new MuscleResponse()
                        muscleResponse.id = muscle.id
                        muscleResponse.name = muscle.name
                        muscleResponse.type = muscle.type
                        muscleResponse.muscleTypeId = muscle.muscleTypeId
                        muscleResponse.createdAt = muscle.createdAt
                        muscleResponse.updatedAt = muscle.updatedAt
                        return muscleResponse
                    }
                )
                return muscleType
            }
        )
    }

    private processingMuscle(user, muscle, excluded) {
        let status: MuscleStatusEnum = null

        if (user) {
            if (excluded.some((excludedItem) => excludedItem.muscleId === muscle.id)) {
                status = MuscleStatusEnum.EXCLUDED
            } else {
                const list = [MuscleStatusEnum.LOW, MuscleStatusEnum.MEDIUM, MuscleStatusEnum.HIGH]
                status = list[Math.floor(Math.random() * list.length)];
            }
        }

        const muscleResponse = new MuscleResponse()
        muscleResponse.id = muscle.id
        muscleResponse.name = muscle.name
        muscleResponse.type = muscle.type
        muscleResponse.muscleTypeId = muscle.muscleTypeId
        muscleResponse.status = status
        muscleResponse.createdAt = muscle.createdAt
        muscleResponse.updatedAt = muscle.updatedAt
        return muscleResponse
    }
}
