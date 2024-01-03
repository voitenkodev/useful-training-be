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

        const excludedMuscles = await this.excludedMusclesEntity
            .createQueryBuilder('excluded_muscles')
            .where('excluded_muscles.userId = :userId', {userId: user.id})
            .select(['excluded_muscles.muscleId'])
            .getMany();

        return muscleTypes.map((muscleTypeBundle) => {
                const muscleType = new MuscleTypeResponse()
                muscleType.id = muscleTypeBundle.id
                muscleType.name = muscleTypeBundle.name
                muscleType.type = muscleTypeBundle.type
                muscleType.createdAt = muscleTypeBundle.createdAt
                muscleType.updatedAt = muscleTypeBundle.updatedAt
                muscleType.muscles = muscleTypeBundle.muscles.map((muscleBundle) => {
                        return this.processingMuscle(user, muscleBundle, excludedMuscles)
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

        const excludedMuscles = await this.excludedMusclesEntity
            .createQueryBuilder('excluded_muscles')
            .where('excluded_muscles.userId = :userId', {userId: user.id})
            .select(['excluded_muscles.muscleId'])
            .getMany();

        return this.processingMuscle(user, muscle, excludedMuscles)
    }

    async getPublicMuscles() {
        const muscleTypes = await this.muscleTypeRepository
            .createQueryBuilder('muscle_types')
            .leftJoinAndSelect('muscle_types.muscles', 'muscles')
            .getMany();

        return muscleTypes.map((muscleTypeBundle) => {
                const muscleType = new MuscleTypeResponse()
                muscleType.id = muscleTypeBundle.id
                muscleType.name = muscleTypeBundle.name
                muscleType.type = muscleTypeBundle.type
                muscleType.createdAt = muscleTypeBundle.createdAt
                muscleType.updatedAt = muscleTypeBundle.updatedAt
                muscleType.muscles = muscleTypeBundle.muscles.map((muscle) => {
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

    private processingMuscle(user, muscle, excludedMuscles) {
        let status: MuscleStatusEnum = null

        if (user) {
            if (excludedMuscles.some((excludedMuscle) => excludedMuscle.muscleId === muscle.id)) {
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
