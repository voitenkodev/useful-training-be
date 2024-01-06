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
import {EquipmentTypesEntity} from "./equipment-types.entity";
import {EquipmentEnum} from "../lib/equipment.enum";
import {ExcludedEquipmentsEntity} from "./excluded-equipments.entity";

@Entity({name: 'equipment'})
export class EquipmentEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({default: null})
    equipmentTypeId: string;

    @Column({type: 'enum', enum: EquipmentEnum, nullable: true})
    type: EquipmentEnum;

    @CreateDateColumn({type: 'timestamp without time zone', name: 'created_at',})
    createdAt: Date;

    @UpdateDateColumn({type: 'timestamp without time zone', name: 'updated_at',})
    updatedAt: Date;

    @ManyToOne(() => EquipmentTypesEntity, (equipmentTypes) => equipmentTypes.equipments, {
        onDelete: 'CASCADE',
        orphanedRowAction: 'delete',
    })

    @JoinColumn({name: 'equipment_type_id'})
    equipmentTypes: EquipmentTypesEntity;

    @OneToMany(() => ExcludedEquipmentsEntity, (excludedEquipments) => excludedEquipments.equipments, {
        cascade: ['remove']
    })
    excludedEquipments: ExcludedEquipmentsEntity[];
}
