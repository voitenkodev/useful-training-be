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

@Entity({name: 'exercise_examples'})
export class ExerciseExamplesEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({default: null})
    userId: string;

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
        orphanedRowAction: 'delete',
    })
    @JoinColumn({name: 'user_id'})
    user: UsersEntity;
}
