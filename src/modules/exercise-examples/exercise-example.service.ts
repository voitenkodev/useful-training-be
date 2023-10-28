import {Inject, Injectable} from '@nestjs/common';
import {UsersEntity} from '../../entities/users.entity';
import {Repository} from 'typeorm';
import {v4} from 'uuid';
import {ExerciseExamplesEntity} from "../../entities/exercise-examples.entity";
import {MuscleExerciseBundlesEntity} from "../../entities/muscle-exercise-bundles.entity";
import {MusclesEntity} from "../../entities/muscles.entity";
import {ExerciseExampleRequestDto} from "./dto/exercise-example-request.dto";

@Injectable()
export class ExerciseExampleService {
    constructor(
        @Inject('USERS_REPOSITORY')
        private readonly usersRepository: Repository<UsersEntity>,
        @Inject('EXERCISE_EXAMPLES_REPOSITORY')
        private readonly exerciseExamplesRepository: Repository<ExerciseExamplesEntity>,
        @Inject('MUSCLE_EXERCISE_BUNDLES_REPOSITORY')
        private readonly muscleExerciseBundlesRepository: Repository<MuscleExerciseBundlesEntity>,
        @Inject('MUSCLES_REPOSITORY')
        private readonly musclesRepository: Repository<MusclesEntity>,
    ) {
    }

    async getAllExerciseExamples(user) {
        return this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.muscleExerciseBundles', 'muscleExerciseBundles')
            .leftJoinAndSelect('muscleExerciseBundles.muscle', 'muscle')
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .getMany();
    }

    async getExerciseExamplesById(id: string, user) {
        return this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.id = :id', {id})
            .andWhere('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.muscleExerciseBundles', 'muscleExerciseBundles')
            .leftJoinAndSelect('muscleExerciseBundles.muscle', 'muscle')
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .getOne();
    }

    async setOrUpdateExerciseExample(body: ExerciseExampleRequestDto, user) {
        const {muscleExerciseBundles, ...rest} = body;

        const exerciseExample = new ExerciseExamplesEntity();
        Object.assign(exerciseExample, rest);
        exerciseExample.id = !exerciseExample.id ? v4() : exerciseExample.id;
        exerciseExample.userId = user.id;

        const muscleExerciseExampleBundlesEntities = [];

        muscleExerciseBundles.forEach((el) => {
            const muscleExerciseExampleBundles = new MuscleExerciseBundlesEntity();
            Object.assign(muscleExerciseExampleBundles, el);
            muscleExerciseExampleBundles.id = !muscleExerciseExampleBundles.id ? v4() : muscleExerciseExampleBundles.id;
            muscleExerciseExampleBundles.muscleId = el.muscleId;
            muscleExerciseExampleBundles.exerciseExampleId = exerciseExample.id;
            muscleExerciseExampleBundlesEntities.push(muscleExerciseExampleBundles);
        });

        await this.exerciseExamplesRepository.save(exerciseExample);
        await this.muscleExerciseBundlesRepository.save(muscleExerciseExampleBundlesEntities);

        return this.getExerciseExamplesById(exerciseExample.id, user);
    }
}
