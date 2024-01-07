import {ApiProperty} from '@nestjs/swagger';
import {EquipmentEnum} from "../../../lib/equipment.enum";
import {EquipmentGroupEnum} from "../../../lib/equipment-group.enum";
import {EquipmentStatusEnum} from "../../../lib/equipment-status.enum";

export class EquipmentResponse {
    id?: string;

    @ApiProperty({type: 'string', example: 'biceps'})
    name: string;

    @ApiProperty({type: 'string', example: '4289bf91-51d8-40b0-9aca-66780584a4eb'})
    equipmentGroupId: string;

    @ApiProperty({type: 'enum', enum: EquipmentEnum, example: EquipmentEnum.AB_MACHINES})
    type: EquipmentEnum;

    @ApiProperty({type: 'enum', enum: EquipmentStatusEnum, example: EquipmentStatusEnum.INCLUDED})
    status: EquipmentStatusEnum;

    @ApiProperty({type: Date, example: Date.now()})
    updatedAt: Date;

    @ApiProperty({type: Date, example: Date.now()})
    createdAt: Date;
}

export class EquipmentGroupResponse {
    id?: string;

    @ApiProperty({type: 'string', example: 'Machines'})
    name: string;

    @ApiProperty({type: 'enum', enum: EquipmentGroupEnum, example: EquipmentGroupEnum.BENCHES_AND_RACKS})
    type: EquipmentGroupEnum;

    @ApiProperty({type: [EquipmentResponse]})
    equipments: EquipmentResponse[];

    @ApiProperty({type: Date, example: Date.now()})
    updatedAt: Date;

    @ApiProperty({type: Date, example: Date.now()})
    createdAt: Date;
}