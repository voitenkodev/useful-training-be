import {Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn,} from 'typeorm';
import {TrainingsEntity} from './trainings.entity';
import {ExerciseExamplesEntity} from "./exercise-examples.entity";
import {WeightHistoryEntity} from "./weight-history.entity";
import {ExcludedMusclesEntity} from "./excluded-muscles.entity";
import {ExcludedEquipmentsEntity} from "./excluded-equipments.entity";
import {UserExperienceEnum} from "../lib/user-experience.enum";

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

    @Column({type: 'double precision'})
    height: number;

    @CreateDateColumn({type: 'timestamp without time zone', name: 'created_at',})
    createdAt: Date;

    @UpdateDateColumn({type: 'timestamp without time zone', name: 'updated_at',})
    updatedAt: Date;

    @Column({type: 'enum', enum: UserExperienceEnum, nullable: true})
    experience: UserExperienceEnum;

    @OneToMany(() => TrainingsEntity, (trainings) => trainings.user, {
        cascade: ['remove'],
    })
    trainings: TrainingsEntity[];

    @OneToMany(() => ExerciseExamplesEntity, (exerciseExamples) => exerciseExamples.user, {
        cascade: ['remove'],
    })
    exerciseExamples: ExerciseExamplesEntity[];

    @OneToMany(() => WeightHistoryEntity, (weights) => weights.user, {
        cascade: ['remove'],
    })
    weights: WeightHistoryEntity[];

    @OneToMany(() => ExcludedMusclesEntity, (excludeMuscles) => excludeMuscles.user, {
        cascade: ['remove'],
    })
    excludedMuscles: ExcludedMusclesEntity[];

    @OneToMany(() => ExcludedEquipmentsEntity, (excludeEquipments) => excludeEquipments.user, {
        cascade: ['remove'],
    })
    excludedEquipments: ExcludedEquipmentsEntity[];
}
