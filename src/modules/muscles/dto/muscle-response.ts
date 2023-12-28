import {ApiProperty} from '@nestjs/swagger';
import {MuscleEnum} from "../../../lib/muscle.enum";
import {MuscleStatusEnum} from "../../../lib/muscle-status.enum";
import {MuscleTypeEnum} from "../../../lib/muscle-type.enum";

export class MuscleResponse {
    id?: string;

    @ApiProperty({type: 'string', example: 'biceps'})
    name: string;

    @ApiProperty({type: 'string', example: '4289bf91-51d8-40b0-9aca-66780584a4eb'})
    muscleTypeId: string;

    @ApiProperty({type: 'enum', enum: MuscleEnum, example: MuscleEnum.BICEPS})
    type: MuscleEnum;

    @ApiProperty({type: 'enum', enum: MuscleStatusEnum, example: MuscleStatusEnum.LOW})
    status: MuscleStatusEnum;

    @ApiProperty({type: Date, example: Date.now()})
    updatedAt: Date;

    @ApiProperty({type: Date, example: Date.now()})
    createdAt: Date;
}

export class MuscleTypeResponse {
    id?: string;

    @ApiProperty({type: 'string', example: 'Back Muscles'})
    name: string;

    @ApiProperty({type: 'enum', enum: MuscleTypeEnum, example: MuscleTypeEnum.BACK_MUSCLES})
    type: MuscleTypeEnum;

    @ApiProperty({type: [MuscleResponse]})
    muscles: MuscleResponse[];

    @ApiProperty({type: Date, example: Date.now()})
    updatedAt: Date;

    @ApiProperty({type: Date, example: Date.now()})
    createdAt: Date;
}