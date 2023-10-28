import {Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {MusclesEntity} from "../../entities/muscles.entity";

@Injectable()
export class MusclesService {
    constructor(
        @Inject('MUSCLES_REPOSITORY')
        private readonly musclesRepository: Repository<MusclesEntity>,
    ) {
    }

    async getMuscles() {
        return this.musclesRepository
            .createQueryBuilder('muscles')
            .getMany();
    }

    async getMuscleById(id: string) {
        return this.musclesRepository
            .createQueryBuilder('muscles')
            .where('muscles.id = :id', {id})
            .getOne();
    }
}
