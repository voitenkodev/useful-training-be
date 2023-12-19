import {ApiProperty} from '@nestjs/swagger';

export class UserResponse {

    @ApiProperty({type: 'string', example: "userId"})
    id?: string;

    @ApiProperty({type: 'string', example: "user@mail.com", description: 'email'})
    email: string;

    @ApiProperty({type: 'string', example: "Max", description: 'minutes'})
    name: string;

    @ApiProperty({type: 'double', example: 85.0, description: 'kg'})
    weight: number;

    @ApiProperty({type: 'double', example: 175.0, description: 'meter'})
    height: number;
}