import {
    Column,
    CreateDateColumn,
    Entity, JoinColumn,
    ManyToOne,
    OneToMany,
    PrimaryGeneratedColumn,
    UpdateDateColumn,
} from 'typeorm';
import {MuscleExerciseBundlesEntity} from './muscle-exercise-bundles.entity';
import {UsersEntity} from "./users.entity";
import {MuscleTypesEntity} from "./muscle-types.entity";

enum MuscleType {
    Chest = 'chest',
    Back = 'back',
    Shoulders = 'shoulders',
    Biceps = 'biceps',
    Triceps = 'triceps',
    Abdominal = 'abdominal',
    Legs = 'legs',
    Other = 'other'
}

@Entity({name: 'muscles'})
export class MusclesEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({default: null})
    muscleTypeId: string;

    @Column({default: null})
    name_ua: string;

    @Column({default: null})
    name_ru: string;

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

}
