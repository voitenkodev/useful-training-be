import {DataSource} from 'typeorm';
import {UsersEntity} from '../entities/users.entity';
import {ExercisesEntity} from '../entities/exercises.entity';
import {IterationsEntity} from '../entities/iterations.entity';
import {TrainingsEntity} from '../entities/trainings.entity';
import {MuscleExerciseBundlesEntity} from '../entities/muscle-exercise-bundles.entity';
import {MusclesEntity} from '../entities/muscles.entity';
import {ExerciseExamplesEntity} from '../entities/exercise-examples.entity';
import {MuscleTypesEntity} from "../entities/muscle-types.entity";
import {UserWeightsEntity} from "../entities/user-weights.entity";

export const repositoryProviders = [
    {
        provide: 'USERS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(UsersEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'USER_WEIGHTS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(UserWeightsEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EXERCISES_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(ExercisesEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'ITERATIONS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(IterationsEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'TRAININGS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(TrainingsEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'MUSCLES_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(MusclesEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'MUSCLE_TYPES_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(MuscleTypesEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'MUSCLE_EXERCISE_BUNDLES_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(MuscleExerciseBundlesEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EXERCISE_EXAMPLES_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(ExerciseExamplesEntity),
        inject: ['DATA_SOURCE'],
    }
];
