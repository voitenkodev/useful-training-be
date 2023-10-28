import {
  Column,
  CreateDateColumn,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { MuscleExerciseBundlesEntity } from './muscle-exercise-bundles.entity';

@Entity({ name: 'exercise_examples' })
export class ExerciseExamplesEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ default: null })
  name: string;

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

  @OneToMany(
    () => MuscleExerciseBundlesEntity,
    (musclesBundle) => musclesBundle.exerciseExample,
    {
      cascade: ['remove'],
    },
  )
  muscleExerciseBundle: MuscleExerciseBundlesEntity[];
}
