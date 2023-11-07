import {Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn,} from 'typeorm';
import {TrainingsEntity} from './trainings.entity';
import {ExerciseExamplesEntity} from "./exercise-examples.entity";

@Entity({name: 'users'})
export class UsersEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({unique: true, nullable: false})
    email: string;

    @Column({select: false})
    password: string;

    @Column()
    name: string;

    @Column()
    weight: number;

    @Column()
    height: number;

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

    @OneToMany(() => TrainingsEntity, (trainings) => trainings.user, {
        cascade: ['remove'],
    })
    trainings: TrainingsEntity[];

    @OneToMany(() => ExerciseExamplesEntity, (exerciseExamples) => exerciseExamples.user, {
        cascade: ['remove'],
    })
    exerciseExamples: ExerciseExamplesEntity[];
}
