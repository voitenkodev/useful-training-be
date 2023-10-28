import {
  Column,
  CreateDateColumn,
  Entity,
  OneToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { MuscleExerciseBundlesEntity } from './muscle-exercise-bundles.entity';

@Entity({ name: 'muscles' })
export class MusclesEntity {
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

  @OneToOne(() => MuscleExerciseBundlesEntity, (muscleExerciseBundle) => muscleExerciseBundle.muscle)
  muscleExerciseBundle: MuscleExerciseBundlesEntity;
}
