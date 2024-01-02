import {Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {MusclesEntity} from "../../entities/muscles.entity";
import {MuscleTypesEntity} from "../../entities/muscle-types.entity";
import {MuscleResponse, MuscleTypeResponse} from "./dto/muscle-response";
import {MuscleStatusEnum} from "../../lib/muscle-status.enum";

@Injectable()
export class MusclesService {
    constructor(
        @Inject('MUSCLES_REPOSITORY')
        private readonly musclesRepository: Repository<MusclesEntity>,
        @Inject('MUSCLE_TYPES_REPOSITORY')
        private readonly muscleTypeRepository: Repository<MuscleTypesEntity>,
    ) {
    }

    async getMuscles() {
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

                muscleType.muscles = muscleTypeBundle.muscles.map((muscleBundle) => {

                    const muscleResponse = new MuscleResponse()
                    muscleResponse.id = muscleBundle.id
                    muscleResponse.name = muscleBundle.name
                    muscleResponse.type = muscleBundle.type
                    muscleResponse.muscleTypeId = muscleBundle.muscleTypeId

                    const statusValues = Object.values(MuscleStatusEnum); // random value
                    muscleResponse.status = statusValues[Math.floor(Math.random() * statusValues.length)];

                    muscleResponse.createdAt = muscleBundle.createdAt
                    muscleResponse.updatedAt = muscleBundle.updatedAt
                    return muscleResponse
                })

                return muscleType
            }
        )
    }

    async getMuscleById(id: string) {
        const muscle: MusclesEntity = await this.musclesRepository
            .createQueryBuilder('muscles')
            .where('muscles.id = :id', {id})
            .getOne();

        const muscleResponse = new MuscleResponse()
        muscleResponse.id = muscle.id
        muscleResponse.name = muscle.name
        muscleResponse.type = muscle.type
        muscleResponse.muscleTypeId = muscle.muscleTypeId

        const statusValues = Object.values(MuscleStatusEnum); // random value
        muscleResponse.status = statusValues[Math.floor(Math.random() * statusValues.length)];

        muscleResponse.createdAt = muscle.createdAt
        muscleResponse.updatedAt = muscle.updatedAt

        return muscleResponse
    }
}
