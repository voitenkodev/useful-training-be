import {Inject, Injectable} from '@nestjs/common';
import {UsersEntity} from '../../entities/users.entity';
import {Repository} from 'typeorm';
import {v4} from 'uuid';
import {ExerciseExamplesEntity} from "../../entities/exercise-examples.entity";
import {ExerciseExampleBundlesEntity} from "../../entities/exercise-example-bundles.entity";
import {MusclesEntity} from "../../entities/muscles.entity";
import {ExerciseExampleRequest} from "./dto/exercise-example.request";

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
    ) {
    }

    async getAllExerciseExamples(user) {
        return this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exerciseExampleBundles')
            .leftJoinAndSelect('exerciseExampleBundles.muscle', 'muscle')
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .getMany();
    }

    async getRecommendedExerciseExamples(user) {
        return this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exerciseExampleBundles')
            .leftJoinAndSelect('exerciseExampleBundles.muscle', 'muscle')
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .getMany();
    }

    async getExerciseExamplesById(id: string, user) {
        return this.exerciseExamplesRepository
            .createQueryBuilder('exercise_examples')
            .where('exercise_examples.id = :id', {id})
            .andWhere('exercise_examples.userId = :userId', {userId: user.id})
            .leftJoinAndSelect('exercise_examples.exerciseExampleBundles', 'exerciseExampleBundles')
            .leftJoinAndSelect('exerciseExampleBundles.muscle', 'muscle')
            .addOrderBy('exercise_examples.createdAt', 'DESC')
            .getOne();
    }

    async setOrUpdateExerciseExample(body: ExerciseExampleRequest, user) {
        const {exerciseExampleBundles, ...rest} = body;

        const exerciseExample = new ExerciseExamplesEntity();
        Object.assign(exerciseExample, rest);
        exerciseExample.id = !exerciseExample.id ? v4() : exerciseExample.id;
        exerciseExample.userId = user.id;

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

        return this.getExerciseExamplesById(exerciseExample.id, user);
    }
}
