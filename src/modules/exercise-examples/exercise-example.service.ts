import {Inject, Injectable} from '@nestjs/common';
import {UsersEntity} from '../../entities/users.entity';
import {Repository} from 'typeorm';
import {ExerciseExamplesEntity} from "../../entities/exercise-examples.entity";
import {MuscleExerciseBundlesEntity} from "../../entities/muscle-exercise-bundles.entity";
import {MusclesEntity} from "../../entities/muscles.entity";

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
}
