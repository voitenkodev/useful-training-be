import { ApiProperty } from '@nestjs/swagger';

export class LoginRequest {
  @ApiProperty({ example: 'user@mail.com', type: 'string' })
  email: string;

  @ApiProperty({ example: 'password', type: 'string' })
  password: string;
}
