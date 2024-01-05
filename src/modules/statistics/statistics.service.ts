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
        return this.iterationsRepository
            .createQueryBuilder("iterations")
            .leftJoin('iterations.exercise', 'exercise')
            .leftJoin('exercise.exerciseExample', 'exerciseExample')
            .where('exercise.exerciseExampleId = :id', {id})
            .andWhere('exerciseExample.userId = :userId', { userId: user.id })
            .select([
                'iterations.id',
                'exercise.id',
                'exerciseExample.id',
                'iterations.weight',
            ])
            .orderBy('iterations.weight', "DESC")
            .getOne();
    }
}
