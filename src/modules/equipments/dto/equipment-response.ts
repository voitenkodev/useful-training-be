import {ApiProperty} from '@nestjs/swagger';
import {EquipmentEnum} from "../../../lib/equipment.enum";
import {EquipmentTypeEnum} from "../../../lib/equipment-type.enum";
import {EquipmentStatusEnum} from "../../../lib/equipment-status.enum";

export class EquipmentResponse {
    id?: string;

    @ApiProperty({type: 'string', example: 'biceps'})
    name: string;

    @ApiProperty({type: 'string', example: '4289bf91-51d8-40b0-9aca-66780584a4eb'})
    equipmentTypeId: string;

    @ApiProperty({type: 'enum', enum: EquipmentEnum, example: EquipmentEnum.AB_MACHINES})
    type: EquipmentEnum;

    @ApiProperty({type: 'enum', enum: EquipmentStatusEnum, example: EquipmentStatusEnum.INCLUDED})
    status: EquipmentStatusEnum;

    @ApiProperty({type: Date, example: Date.now()})
    updatedAt: Date;

    @ApiProperty({type: Date, example: Date.now()})
    createdAt: Date;
}

export class EquipmentTypeResponse {
    id?: string;

    @ApiProperty({type: 'string', example: 'Machines'})
    name: string;

    @ApiProperty({type: 'enum', enum: EquipmentTypeEnum, example: EquipmentTypeEnum.BENCHES_AND_RACKS})
    type: EquipmentTypeEnum;

    @ApiProperty({type: [EquipmentResponse]})
    equipments: EquipmentResponse[];

    @ApiProperty({type: Date, example: Date.now()})
    updatedAt: Date;

    @ApiProperty({type: Date, example: Date.now()})
    createdAt: Date;
}