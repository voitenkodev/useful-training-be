import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { ExercisesEntity } from './exercises.entity';

@Entity({ name: 'iterations' })
export class IterationsEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'double precision', default: null })
  weight: number;

  @Column({ default: null })
  repetitions: number;

  @Column({ default: null })
  exerciseId: string;

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

  @ManyToOne(() => ExercisesEntity, (exercise) => exercise.iterations, {
    onDelete: 'CASCADE',
    orphanedRowAction: 'delete',
  })
  @JoinColumn({ name: 'exercise_id' })
  exercise: ExercisesEntity;
}
