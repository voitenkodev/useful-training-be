import {ApiProperty} from '@nestjs/swagger';
import {Column} from "typeorm";
import {WeightTypeEnum} from "../../../lib/weight-type.enum";
import {UserExperienceEnum} from "../../../lib/user-experience.enum";

export class RegisterRequest {

    @ApiProperty({example: 'user@mail.com', type: 'string'})
    email: string;

    @ApiProperty({example: 'password', type: 'string'})
    password: string;

    @ApiProperty({example: 'Max', type: 'string'})
    name: string;

    @ApiProperty({example: 850, type: 'number', description: '850 = 85g'})
    weight: number;

    @ApiProperty({example: 175, type: 'number', description: '175 = 175cm'})
    height: number;


    @ApiProperty({example: UserExperienceEnum.PRO, type: 'enum', description: 'user experience'})
    experience: UserExperienceEnum;

    @ApiProperty({example: ['2e0faf2b-31a5-4c63-ac15-454be132796f'], type: 'list', description: 'excluded muscle ids'})
    excludeMuscleIds: string[];

    @ApiProperty({
        example: ['4e062209-1ddb-453a-a42b-4f9e0b0292f4'],
        type: 'list',
        description: 'equipment ids'
    })
    excludeEquipmentIds: string[];
}
