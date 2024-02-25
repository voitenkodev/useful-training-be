import {BadRequestException, Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {ExcludedMusclesEntity} from "../../entities/excluded-muscles.entity";
import {MusclesEntity} from "../../entities/muscles.entity";

@Injectable()
export class ExcludedMusclesService {
    constructor(
        @Inject('EXCLUDED_MUSCLES_REPOSITORY')
        private readonly excludedMusclesEntity: Repository<ExcludedMusclesEntity>,
        @Inject('MUSCLES_REPOSITORY')
        private readonly musclesRepository: Repository<MusclesEntity>
    ) {
    }

    async getExcludedMuscles(user) {
        return await this.excludedMusclesEntity
            .createQueryBuilder('excluded_muscles')
            .where('excluded_muscles.userId = :userId', {userId: user.id})
            .getMany()
    }

    async setExcludedMuscle(user, id: string) {
        const excludedMuscle = await this.excludedMusclesEntity
            .createQueryBuilder('excluded_muscles')
            .where('excluded_muscles.userId = :userId', {userId: user.id})
            .andWhere('excluded_muscles.muscleId = :muscleId', {muscleId: id})
            .getOne();

        if (excludedMuscle != null) {
            throw new BadRequestException('This muscle already excluded');
        }

        const muscle = await this.musclesRepository
            .createQueryBuilder("muscles")
            .where('muscles.id = :id', {id: id})
            .getOne();

        if (muscle == null) {
            throw new BadRequestException('Unknown muscle');
        }

        const excludedMusclesEntity = new ExcludedMusclesEntity()
        excludedMusclesEntity.muscleId = id
        excludedMusclesEntity.userId = user.id

        return await this.excludedMusclesEntity.save(excludedMusclesEntity)
    }

    async deleteExcludedMuscle(user, id: string) {
        const excludedMuscle = await this.excludedMusclesEntity
            .createQueryBuilder('excluded_muscles')
            .where('excluded_muscles.userId = :userId', {userId: user.id})
            .andWhere('excluded_muscles.muscleId = :muscleId', {muscleId: id})
            .getOne();

        if (excludedMuscle == null) {
            throw new BadRequestException('This muscle is not excluded');
        }

        return await this.excludedMusclesEntity.remove(excludedMuscle)
    }
}
