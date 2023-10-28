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
import { TrainingsEntity } from './trainings.entity';
import { IterationsEntity } from './iterations.entity';

@Entity({ name: 'exercises' })
export class ExercisesEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ default: null })
  name: string;

  @Column({ type: 'double precision', default: null })
  tonnage: number;

  @Column({ default: null })
  countOfLifting: number;

  @Column({ type: 'double precision', default: null })
  intensity: number;

  @Column({ default: null })
  trainingId: string;

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

  @ManyToOne(() => TrainingsEntity, (training) => training.exercises, {
    onDelete: 'CASCADE',
    orphanedRowAction: 'delete',
  })
  @JoinColumn({ name: 'training_id' })
  training: TrainingsEntity;

  @OneToMany(() => IterationsEntity, (iterations) => iterations.exercise, {
    cascade: ['remove'],
  })
  iterations: IterationsEntity[];
}
