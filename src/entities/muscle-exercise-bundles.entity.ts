import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { ExerciseExamplesEntity } from './exercise-examples.entity';
import { MusclesEntity } from './muscles.entity';

@Entity({ name: 'muscle_exercise_bundles' })
export class MuscleExerciseBundlesEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ default: null })
  value: number;

  @Column({ default: null })
  exerciseExampleId: string;

  @Column({ default: null })
  muscleId: string;

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

  @ManyToOne(
    () => ExerciseExamplesEntity,
    (exerciseExample) => exerciseExample.muscleExerciseBundle,
    {
      onDelete: 'CASCADE',
      orphanedRowAction: 'delete',
    },
  )
  @JoinColumn({ name: 'exercise_example_id' })
  exerciseExample: ExerciseExamplesEntity;

  @OneToOne(() => MusclesEntity, (muscle) => muscle.muscleExerciseBundle, {
    onDelete: 'CASCADE',
    orphanedRowAction: 'delete',
  })
  @JoinColumn({ name: 'muscle_id' })
  muscle: MusclesEntity;
}
