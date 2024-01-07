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
import {ExerciseExampleBundlesEntity} from './exercise-example-bundles.entity';
import {MuscleGroupsEntity} from "./muscle-groups.entity";
import {MuscleEnum} from "../lib/muscle.enum";
import {ExcludedMusclesEntity} from "./excluded-muscles.entity";

@Entity({name: 'muscles'})
export class MusclesEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({default: null})
    muscleGroupId: string;

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

    @OneToMany(() => ExerciseExampleBundlesEntity, (exerciseExampleBundle) => exerciseExampleBundle.muscle, {
        cascade: ['remove'],
    })
    exerciseExampleBundles: ExerciseExampleBundlesEntity[];

    @ManyToOne(() => MuscleGroupsEntity, (muscleGroup) => muscleGroup.muscles, {
        onDelete: 'CASCADE',
        orphanedRowAction: 'delete',
    })

    @JoinColumn({name: 'muscle_group_id'})
    muscleGroup: MuscleGroupsEntity;

    @OneToMany(() => ExcludedMusclesEntity, (excludedMuscles) => excludedMuscles.muscle, {
        cascade: ['remove']
    })
    excludedMuscles: ExcludedMusclesEntity[];
}
