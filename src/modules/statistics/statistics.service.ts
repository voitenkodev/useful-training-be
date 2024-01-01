import {Inject, Injectable} from '@nestjs/common';
import {UsersEntity} from '../../entities/users.entity';
import {Repository} from 'typeorm';
import {TrainingsEntity} from '../../entities/trainings.entity';
import {ExercisesEntity} from '../../entities/exercises.entity';
import {IterationsEntity} from '../../entities/iterations.entity';
import {ExerciseExamplesEntity} from "../../entities/exercise-examples.entity";

@Injectable()
export class StatisticsService {
    constructor(
        @Inject('USERS_REPOSITORY')
        private readonly usersRepository: Repository<UsersEntity>,
        @Inject('TRAININGS_REPOSITORY')
        private readonly trainingsRepository: Repository<TrainingsEntity>,
        @Inject('EXERCISES_REPOSITORY')
        private readonly exercisesRepository: Repository<ExercisesEntity>,
        @Inject('ITERATIONS_REPOSITORY')
        private readonly iterationsRepository: Repository<IterationsEntity>,
        @Inject('EXERCISE_EXAMPLES_REPOSITORY')
        private readonly exerciseExamplesRepository: Repository<ExerciseExamplesEntity>,
    ) {
    }

    async getStatistics(id: string, user) {
        return this.exerciseExamplesRepository
            .createQueryBuilder("exercise_examples")
            .where('exercise_examples.userId = :userId', {userId: user.id})
            .andWhere('exercise_examples.id = :id ', {id})
            .leftJoin('exercise_examples.exercises', "exercises")
            .leftJoin('exercises.iterations', "iterations")
            .addSelect([
                    'exercise_examples.id',
                    'exercises.id',
                    'iterations.id',
                    'MAX(iterations.weight) as max_weight'
                ]
            )
            .groupBy('exercise_examples.id')
            .addGroupBy('exercises.id')
            .addGroupBy('iterations.id')
            .addGroupBy('iterations.weight')
            .getOne()
    }
}
