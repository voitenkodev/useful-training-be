import {Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn,} from 'typeorm';
import {EquipmentTypeEnum} from "../lib/equipment-type.enum";
import {EquipmentEntity} from "./equipment.entity";

@Entity({name: 'equipment_types'})
export class EquipmentTypesEntity {

    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({type: 'enum', enum: EquipmentTypeEnum, nullable: true})
    type: EquipmentTypeEnum;

    @CreateDateColumn({type: 'timestamp without time zone', name: 'created_at'})
    createdAt: Date;

    @UpdateDateColumn({type: 'timestamp without time zone', name: 'updated_at'})
    updatedAt: Date;

    @OneToMany(() => EquipmentEntity, (equipment) => equipment.equipmentTypes, {
        cascade: ['remove']
    })
    equipments: EquipmentEntity[];
}
