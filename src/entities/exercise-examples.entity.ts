import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToOne,
    OneToMany,
    PrimaryGeneratedColumn,
    UpdateDateColumn,
} from 'typeorm';
import {MuscleExerciseBundlesEntity} from './muscle-exercise-bundles.entity';
import {UsersEntity} from "./users.entity";
import {ExercisesEntity} from "./exercises.entity";
import {ExerciseCategoryEnum} from "../lib/exercise-category.enum";
import {WeightTypeEnum} from "../lib/weight-type.enum";

@Entity({name: 'exercise_examples'})
export class ExerciseExamplesEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({default: null})
    description: string;

    @Column({default: null})
    imageUrl: string;

    @Column({default: null})
    userId: string;

    @Column({type: 'enum', enum: ExerciseCategoryEnum, nullable: true})
    category: ExerciseCategoryEnum;

    @Column({type: 'enum', enum: WeightTypeEnum, nullable: true})
    weightType: WeightTypeEnum;

    @CreateDateColumn({
        type: 'timestamp without time zone',
        name: 'created_at',
    })
    createdAt: Date;

    @UpdateDateColumn({
        type: 'timestamp without time zone',
        name: 'updated_at',
    })
    updatedAt: Date;

    @OneToMany(() => MuscleExerciseBundlesEntity, (muscleExerciseBundle) => muscleExerciseBundle.exerciseExample, {
        cascade: ['remove'],
    })
    muscleExerciseBundles: MuscleExerciseBundlesEntity[];

    @ManyToOne(() => UsersEntity, (user) => user.exerciseExamples, {
        onDelete: 'CASCADE',
        orphanedRowAction: 'delete'
    })
    @JoinColumn({name: 'user_id'})
    user: UsersEntity;

    @OneToMany(() => ExercisesEntity, (exercises) => exercises.exerciseExample, {
        cascade: ['remove']
    })
    exercises: ExercisesEntity[];
}
