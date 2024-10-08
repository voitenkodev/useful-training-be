import {Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn,} from 'typeorm';
import {MusclesEntity} from "./muscles.entity";
import {MuscleTypeEnum} from "../lib/muscle-type.enum";

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

    @Column({type: 'enum', enum: MuscleTypeEnum, nullable: true})
    type: MuscleTypeEnum;

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
