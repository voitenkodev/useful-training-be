import {
  Column,
  CreateDateColumn,
  Entity, Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { ExercisesEntity } from './exercises.entity';
import { UsersEntity } from './users.entity';

@Entity({ name: 'trainings' })
export class TrainingsEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ default: null })
  duration: number;

  @Column({ type: 'double precision', default: null })
  volume: number;

  @Column({ default: null })
  repetitions: number;

  @Column({ type: 'double precision', default: null })
  intensity: number;

  @Column({ default: null })
  userId: string;

  @Index()
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

  @OneToMany(() => ExercisesEntity, (exercises) => exercises.training, {
    cascade: ['remove'],
  })
  exercises: ExercisesEntity[];

  @ManyToOne(() => UsersEntity, (user) => user.trainings, {
    onDelete: 'CASCADE',
    orphanedRowAction: 'delete',
  })
  @JoinColumn({ name: 'user_id' })
  user: UsersEntity;
}
