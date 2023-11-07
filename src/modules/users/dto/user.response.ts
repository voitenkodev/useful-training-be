import {ApiProperty} from '@nestjs/swagger';

export class UserResponse {

    @ApiProperty({type: 'string', example: "userId"})
    id?: string;

    @ApiProperty({type: 'string', example: "user@mail.com", description: 'cm'})
    email: string;

    @ApiProperty({type: 'string', example: "Max", description: 'minutes'})
    name: string;

    @ApiProperty({type: 'number', example: 850, description: 'kg'})
    weight: number;

    @ApiProperty({type: 'number', example: 1750, description: 'cm'})
    height: number;
}