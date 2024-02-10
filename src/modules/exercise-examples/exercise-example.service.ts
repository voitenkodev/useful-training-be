import {Inject, Injectable} from '@nestjs/common';
import {UsersEntity} from '../../entities/users.entity';
import {Repository} from 'typeorm';
import {v4} from 'uuid';
import {ExerciseExamplesEntity} from "../../entities/exercise-examples.entity";
import {ExerciseExampleBundlesEntity} from "../../entities/exercise-example-bundles.entity";
import {MusclesEntity} from "../../entities/muscles.entity";
import {ExerciseExampleRequest} from "./dto/exercise-example.request";
import {EquipmentsEntity} from "../../entities/equipments.entity";
import {ExerciseExamplesEquipmentsEntity} from "../../entities/exercise-examples-equipments.entity";
import {ExerciseExamplesTutorialsEntity} from "../../entities/exercise-examples-tutorials.entity";

@Injectable()
export class ExerciseExampleService {
    constructor(
        @Inject('USERS_REPOSITORY')
        private readonly usersRepository: Repository<UsersEntity>,
        @Inject('EXERCISE_EXAMPLES_REPOSITORY')
        private readonly exerciseExamplesRepository: Repository<ExerciseExamplesEntity>,
        @Inject('EXERCISE_EXAMPLE_BUNDLES_REPOSITORY')
        private readonly exerciseExampleBundlesRepository: Repository<ExerciseExampleBundlesEntity>,
        @Inject('MUSCLES_REPOSITORY')
        private readonly musclesRepository: Repository<MusclesEntity>,
        @Inject('EQUIPMENTS_REPOSITORY')
        private readonly equipmentsRepository: Repository<EquipmentsEntity>,
        @Inject('EXERCISE_EXAMPLES_EQUIPMENTS_REPOSITORY')
        private readonly exerciseExamplesEquipmentsRepository: Repository<ExerciseExamplesEquipmentsEntity>,
        @Inject('EXERCISE_EXAMPLES_TUTORIALS_REPOSITORY')
        private readonly exerciseExamplesTutorialsEntityRepository: Repository<ExerciseExamplesTutorialsEntity>,
    ) {
    }

    async getExerciseExamples(
        user,
        page: number,
        size: number,
        filters: {
            query: string, weightType: string, experience: string, forceType: string, category: string,
            muscleIds: string[], equipmentIds: string[]
        }
    ) {

        const {query, weightType, experience, forceType, category, muscleIds, equipmentIds} = filters;

        const queryBuilder = this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exerciseExampleBundles')
            .leftJoinAndSelect('exerciseExampleBundles.muscle', 'muscle')
            .leftJoinAndSelect('exercise_examples.equipmentRefs', 'equipment_refs')
            .leftJoinAndSelect('exercise_examples.tutorials', 'tutorials')
            .leftJoinAndSelect('equipment_refs.equipment', 'equipments')
            .addOrderBy('exercise_examples.createdAt', 'DESC');

        if (query) {
            queryBuilder.andWhere('exercise_examples.name ILIKE :query', {query: `%${query}%`});
        }

        if (weightType) {
            queryBuilder.andWhere('exercise_examples.weightType = :weightType', {weightType});
        }

        if (experience) {
            queryBuilder.andWhere('exercise_examples.experience = :experience', {experience});
        }

        if (forceType) {
            queryBuilder.andWhere('exercise_examples.forceType = :forceType', {forceType});
        }

        if (category) {
            queryBuilder.andWhere('exercise_examples.category = :category', {category});
        }

        if (muscleIds && muscleIds.length > 0) {
            queryBuilder.andWhere('muscle.id IN (:...muscleIds)', {muscleIds});
        }

        if (equipmentIds && equipmentIds.length > 0) {
            queryBuilder.andWhere('equipments.id IN (:...equipmentIds)', {equipmentIds});
        }

        return await queryBuilder
            .skip((page - 1) * size)
            .take(size)
            .getMany()
    }

    async getRecommendedExerciseExamples(
        user,
        page: number,
        size: number,
        training: { exerciseCount: number, exerciseExampleIds: string }
    ) {

        return this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exerciseExampleBundles')
            .leftJoinAndSelect('exerciseExampleBundles.muscle', 'muscle')
            .leftJoinAndSelect('exercise_examples.equipmentRefs', 'equipment_refs')
            .leftJoinAndSelect('exercise_examples.tutorials', 'tutorials')
            .leftJoinAndSelect('equipment_refs.equipment', 'equipments')
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .skip((page - 1) * size)
            .take(size)
            .getMany();
    }

    async getExerciseExampleById(id: string, user) {
        return await this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.id = :id', {id})
            .andWhere('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exerciseExampleBundles')
            .leftJoinAndSelect('exerciseExampleBundles.muscle', 'muscle')
            .leftJoinAndSelect('exercise_examples.equipmentRefs', 'equipment_refs')
            .leftJoinAndSelect('exercise_examples.tutorials', 'tutorials')
            .leftJoinAndSelect('equipment_refs.equipment', 'equipments')
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .getOne();
    }

    async setOrUpdateExerciseExample(body: ExerciseExampleRequest, user) {
        const {exerciseExampleBundles, ...rest} = body;

        const exerciseExample = new ExerciseExamplesEntity();
        Object.assign(exerciseExample, rest);
        exerciseExample.id = !exerciseExample.id ? v4() : exerciseExample.id;
        exerciseExample.userId = user.id;

        const exerciseEquipment = []

        body.equipmentRefs.forEach((el) => {
            const exerciseExamplesEquipmentsEntity = new ExerciseExamplesEquipmentsEntity();
            exerciseExamplesEquipmentsEntity.equipmentId = el.equipmentId
            exerciseExamplesEquipmentsEntity.exerciseExampleId = exerciseExample.id
            exerciseEquipment.push(exerciseExamplesEquipmentsEntity);
        });

        const exerciseExampleBundlesEntities = [];

        exerciseExampleBundles.forEach((el) => {
            const exerciseExampleBundles = new ExerciseExampleBundlesEntity();
            Object.assign(exerciseExampleBundles, el);
            exerciseExampleBundles.id = !exerciseExampleBundles.id ? v4() : exerciseExampleBundles.id;
            exerciseExampleBundles.muscleId = el.muscleId;
            exerciseExampleBundles.exerciseExampleId = exerciseExample.id;
            exerciseExampleBundlesEntities.push(exerciseExampleBundles);
        });

        await this.exerciseExampleBundlesRepository.delete({exerciseExampleId: exerciseExample.id});
        await this.exerciseExamplesRepository.save(exerciseExample);
        await this.exerciseExampleBundlesRepository.save(exerciseExampleBundlesEntities);
        await this.exerciseExamplesEquipmentsRepository.save(exerciseEquipment)

        return this.getExerciseExampleById(exerciseExample.id, user);
    }
}
