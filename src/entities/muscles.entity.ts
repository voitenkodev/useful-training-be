import {
  Column,
  CreateDateColumn,
  Entity,
  OneToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { MusclePackExercisesEntity } from './muscle-pack-exercises.entity';

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

  @OneToOne(() => MusclePackExercisesEntity, (musclePack) => musclePack.muscle)
  musclePack: MusclePackExercisesEntity;
}
