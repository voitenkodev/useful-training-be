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
import {EquipmentGroupsEntity} from "./equipment-groups.entity";
import {EquipmentEnum} from "../lib/equipment.enum";
import {ExcludedEquipmentsEntity} from "./excluded-equipments.entity";

@Entity({name: 'equipments'})
export class EquipmentsEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    name: string;

    @Column({default: null})
    equipmentGroupId: string;

    @Column({type: 'enum', enum: EquipmentEnum, nullable: true})
    type: EquipmentEnum;

    @CreateDateColumn({type: 'timestamp without time zone', name: 'created_at',})
    createdAt: Date;

    @UpdateDateColumn({type: 'timestamp without time zone', name: 'updated_at',})
    updatedAt: Date;

    @ManyToOne(() => EquipmentGroupsEntity, (equipmentGroup) => equipmentGroup.equipments, {
        onDelete: 'CASCADE',
        orphanedRowAction: 'delete',
    })

    @JoinColumn({name: 'equipment_group_id'})
    equipmentGroup: EquipmentGroupsEntity;

    @OneToMany(() => ExcludedEquipmentsEntity, (excludedEquipments) => excludedEquipments.equipment, {
        cascade: ['remove']
    })
    excludedEquipments: ExcludedEquipmentsEntity[];
}
