import {DataSource} from 'typeorm';
import {UsersEntity} from '../entities/users.entity';
import {ExercisesEntity} from '../entities/exercises.entity';
import {IterationsEntity} from '../entities/iterations.entity';
import {TrainingsEntity} from '../entities/trainings.entity';
import {ExerciseExampleBundlesEntity} from '../entities/exercise-example-bundles.entity';
import {MusclesEntity} from '../entities/muscles.entity';
import {ExerciseExamplesEntity} from '../entities/exercise-examples.entity';
import {MuscleGroupsEntity} from "../entities/muscle-groups.entity";
import {WeightHistoryEntity} from "../entities/weight-history.entity";
import {ExcludedMusclesEntity} from "../entities/excluded-muscles.entity";
import {EquipmentsEntity} from "../entities/equipments.entity";
import {ExcludedEquipmentsEntity} from "../entities/excluded-equipments.entity";
import {EquipmentGroupsEntity} from "../entities/equipment-groups.entity";
import {ExerciseExamplesEquipmentsEntity} from "../entities/exercise-examples-equipments.entity";
import {ExerciseExamplesTutorialsEntity} from "../entities/exercise-examples-tutorials.entity";

export const repositoryProviders = [
    {
        provide: 'USERS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(UsersEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'WEIGHT_HISTORY_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(WeightHistoryEntity),
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
        provide: 'MUSCLE_GROUPS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(MuscleGroupsEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EXERCISE_EXAMPLES_TUTORIALS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(ExerciseExamplesTutorialsEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EXCLUDED_MUSCLES_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(ExcludedMusclesEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EXERCISE_EXAMPLE_BUNDLES_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(ExerciseExampleBundlesEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EXERCISE_EXAMPLES_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(ExerciseExamplesEntity),
        inject: ['DATA_SOURCE'],
    }, {
        provide: 'EQUIPMENTS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(EquipmentsEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EQUIPMENT_GROUPS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(EquipmentGroupsEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EXCLUDED_EQUIPMENTS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(ExcludedEquipmentsEntity),
        inject: ['DATA_SOURCE'],
    },
    {
        provide: 'EXERCISE_EXAMPLES_EQUIPMENTS_REPOSITORY',
        useFactory: (dataSource: DataSource) =>
            dataSource.getRepository(ExerciseExamplesEquipmentsEntity),
        inject: ['DATA_SOURCE'],
    }
];
