import { DataSource } from 'typeorm';
import { UsersEntity } from '../entities/users.entity';
import { ExercisesEntity } from '../entities/exercises.entity';
import { IterationsEntity } from '../entities/iterations.entity';
import { TrainingsEntity } from '../entities/trainings.entity';
import { MusclePackExercisesEntity } from '../entities/muscle-pack-exercises.entity';
import { MusclesEntity } from '../entities/muscles.entity';
import { ExerciseExamplesEntity } from '../entities/exercise-examples.entity';

export const repositoryProviders = [
  {
    provide: 'USERS_REPOSITORY',
    useFactory: (dataSource: DataSource) =>
      dataSource.getRepository(UsersEntity),
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
    provide: 'MUSCLE_PACK_EXERCISES_REPOSITORY',
    useFactory: (dataSource: DataSource) =>
      dataSource.getRepository(MusclePackExercisesEntity),
    inject: ['DATA_SOURCE'],
  },
  {
    provide: 'EXERCISE_EXAMPLES_REPOSITORY',
    useFactory: (dataSource: DataSource) =>
      dataSource.getRepository(ExerciseExamplesEntity),
    inject: ['DATA_SOURCE'],
  },
];
