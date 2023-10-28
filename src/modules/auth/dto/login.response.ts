import { ApiProperty } from '@nestjs/swagger';

export class LoginResponse {
  @ApiProperty({ example: 'string' })
  id: string;

  @ApiProperty({ example: 'authorizationToken' })
  accessToken: string;
}
