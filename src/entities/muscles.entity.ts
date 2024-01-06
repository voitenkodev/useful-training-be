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
import {MuscleTypesEntity} from "./muscle-types.entity";
import {MuscleEnum} from "../lib/muscle.enum";
import {ExcludedMusclesEntity} from "./excluded-muscles.entity";

@Entity({name: 'muscles'})
export class MusclesEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({default: null})
    muscleTypeId: string;

    @Column({default: null})
    nameUa: string;

    @Column({type: 'enum', enum: MuscleEnum, nullable: true})
    type: MuscleEnum;

    @Column({type: 'integer', nullable: true})
    recoveryTimeHours: number;

    @Column({default: null})
    nameRu: string;

    @CreateDateColumn({type: 'timestamp without time zone', name: 'created_at',})
    createdAt: Date;

    @UpdateDateColumn({type: 'timestamp without time zone', name: 'updated_at',})
    updatedAt: Date;

    @OneToMany(() => MuscleExerciseBundlesEntity, (muscleExerciseBundle) => muscleExerciseBundle.muscle, {
        cascade: ['remove'],
    })
    muscleExerciseBundles: MuscleExerciseBundlesEntity[];

    @ManyToOne(() => MuscleTypesEntity, (muscleType) => muscleType.muscles, {
        onDelete: 'CASCADE',
        orphanedRowAction: 'delete',
    })

    @JoinColumn({name: 'muscle_type_id'})
    muscleType: MuscleTypesEntity;

    @OneToMany(() => ExcludedMusclesEntity, (excludedMuscles) => excludedMuscles.muscle, {
        cascade: ['remove']
    })
    excludedMuscles: ExcludedMusclesEntity[];
}
