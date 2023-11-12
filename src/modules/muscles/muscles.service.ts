import {Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {MusclesEntity} from "../../entities/muscles.entity";
import {MuscleTypesEntity} from "../../entities/muscle-types.entity";

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
        return this.muscleTypeRepository
            .createQueryBuilder('muscle_types')
            .leftJoinAndSelect('muscle_types.muscles', 'muscles')
            .getMany();
    }

    async getMuscleById(id: string) {
        return this.musclesRepository
            .createQueryBuilder('muscles')
            .where('muscles.id = :id', {id})
            .getOne();
    }
}
