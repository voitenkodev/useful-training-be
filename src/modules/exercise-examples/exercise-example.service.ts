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
import {ExcludedEquipmentsEntity} from "../../entities/excluded-equipments.entity";
import {ExcludedMusclesEntity} from "../../entities/excluded-muscles.entity";
import {RecommendedRequest} from "./dto/recommended.request";
import {FiltersRequest} from "./dto/filters.request";
import {ExperienceEnum} from "../../lib/experience.enum";
import {RecommendedUtils} from "../../lib/recommended.utils";

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
        @Inject('EXCLUDED_EQUIPMENTS_REPOSITORY')
        private readonly excludedEquipmentsRepository: Repository<ExcludedEquipmentsEntity>,
        @Inject('EXCLUDED_MUSCLES_REPOSITORY')
        private excludedMusclesEntity: Repository<ExcludedMusclesEntity>
    ) {
    }

    async getExerciseExamples(user, page: number, size: number, body: FiltersRequest) {

        const {query, weightType, experience, forceType, category, muscleIds, equipmentIds} = body;

        const queryBuilder = this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exerciseExampleBundles')
            .leftJoinAndSelect('exerciseExampleBundles.muscle', 'muscle')
            .leftJoinAndSelect('exercise_examples.equipmentRefs', 'equipment_refs')
            .leftJoinAndSelect('exercise_examples.tutorials', 'tutorials')
            .leftJoinAndSelect('equipment_refs.equipment', 'equipments')

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
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .skip((page - 1) * size)
            .take(size)
            .getMany()
    }

    async getRecommendedExerciseExamples(user, page: number, size: number, body: RecommendedRequest) {

        let recommendations: string[];

        const {targetMuscleId, exerciseExampleIds, exerciseCount} = body;

        const exercisesBuilder = this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exercise_example_bundles')
            .leftJoinAndSelect('exercise_example_bundles.muscle', 'muscle')
            .leftJoinAndSelect('exercise_examples.equipmentRefs', 'equipment_refs')
            .leftJoinAndSelect('exercise_examples.tutorials', 'tutorials')
            .leftJoinAndSelect('equipment_refs.equipment', 'equipments')

        //----------------------------------------

        if (targetMuscleId) {
            exercisesBuilder
                .andWhere('muscle.id = :targetMuscleId', {targetMuscleId})
                .andWhere('exercise_example_bundles.percentage > :percentage', {percentage: 50})
        }

        // ----------------------------------------

        let trainingExerciseExamples = exerciseExampleIds && exerciseExampleIds.length > 0
            ? await this.exerciseExamplesRepository
                .createQueryBuilder('exercise_examples')
                .where('exercise_examples.userId = :userId', {userId: user.id})
                .andWhere('exercise_examples.id IN (:...exerciseExampleIds)', {exerciseExampleIds})
                .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exercise_example_bundles')
                .leftJoinAndSelect('exercise_example_bundles.muscle', 'muscle')
                .getMany() : [];

        switch (user.experience) {
            case ExperienceEnum.BEGINNER: {
                if (exerciseCount >= 4 && exerciseCount <= 8) {
                    recommendations.push("Optimal count of exercises for BEGINNER 3 - 6")
                }

                const count = RecommendedUtils.countOfLastMuscleTargetExercises(trainingExerciseExamples)

                if (count >= 1 && count <= 2) {
                    recommendations.push("Optimal count of exercises per One priority muscle or BEGINNER 1 - 2")
                }
                break;
            }

            case ExperienceEnum.INTERMEDIATE: {
                if (exerciseCount >= 4 && exerciseCount <= 8) {
                    recommendations.push("Optimal count of exercises for INTERMEDIATE 4 - 8")
                }

                const count = RecommendedUtils.countOfLastMuscleTargetExercises(trainingExerciseExamples)

                if (count >= 2 && count <= 3) {
                    recommendations.push("Optimal count of exercises per One priority muscle or INTERMEDIATE 2 - 3")
                }
                break;
            }

            case ExperienceEnum.ADVANCED: {
                if (exerciseCount >= 6 && exerciseCount <= 10) {
                    recommendations.push("Optimal count of exercises for ADVANCED 6 - 10")
                }

                const count = RecommendedUtils.countOfLastMuscleTargetExercises(trainingExerciseExamples)

                if (count >= 3 && count <= 4) {
                    recommendations.push("Optimal count of exercises per One priority muscle or ADVANCED 3 - 4")
                }
                break;
            }

            case ExperienceEnum.PRO: {
                if (exerciseCount >= 8 && exerciseCount <= 12) {
                    recommendations.push("Optimal count of exercises for PRO 8 - 12")
                }

                const count = RecommendedUtils.countOfLastMuscleTargetExercises(trainingExerciseExamples)

                if (count >= 4 && count <= 5) {
                    recommendations.push("Optimal count of exercises per One priority muscle or PRO 4 - 5")
                }
                break;
            }
        }

        // ----------------------------------------

        const excludedUserMuscles = await this.excludedMusclesEntity
            .createQueryBuilder("excluded_muscles")
            .where('excluded_muscles.userId = :userId', {userId: user.id})
            .getMany()

        if (excludedUserMuscles.length > 0) {
            const excludedMuscleIds = excludedUserMuscles.map(muscle => muscle.id);
            exercisesBuilder.andWhere('muscle.id NOT IN (:...excludedMuscleIds)', {excludedMuscleIds});
        }

        // ----------------------------------------

        const excludedUserEquipment = await this.excludedEquipmentsRepository
            .createQueryBuilder("excluded_equipment")
            .where('excluded_equipment.userId = :userId', {userId: user.id})
            .getMany()

        if (excludedUserEquipment.length > 0) {
            const excludedEquipmentIds = excludedUserEquipment.map(equipment => equipment.id);
            exercisesBuilder.andWhere('equipments.id NOT IN (:...excludedEquipmentIds)', {excludedEquipmentIds});
        }

        // ----------------------------------------

        const exercises = await exercisesBuilder
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .skip((page - 1) * size)
            .take(size)
            .getMany()

        return {
            exercises,
            recommendations
        }
    }

    async getExerciseExampleById(id: string, user) {
        return await this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.id = :id', {id})
            .andWhere('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exercise_example_bundles')
            .leftJoinAndSelect('exercise_example_bundles.muscle', 'muscle')
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
