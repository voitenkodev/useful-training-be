import {ApiProperty} from '@nestjs/swagger';

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
}
