import {Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn,} from 'typeorm';
import {MusclesEntity} from "./muscles.entity";

@Entity({name: 'muscle_types'})
export class MuscleTypesEntity {

    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({default: null})
    nameUa: string;

    @Column({default: null})
    nameRu: string;

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

    @OneToMany(() => MusclesEntity, (muscles) => muscles.muscleType, {
        cascade: ['remove']
    })
    muscles: MusclesEntity[];
}
