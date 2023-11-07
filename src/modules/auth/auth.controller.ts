import { Body, Controller, HttpStatus, Post, Req, Res } from '@nestjs/common';
import { AuthService } from './auth.service';
import { ApiResponse, ApiTags } from '@nestjs/swagger';
import { LoginRequest } from './dto/login.request';
import { LoginResponse } from './dto/login.response';
import {RegisterRequest} from "./dto/register.request";

@Controller('auth')
@ApiTags('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @ApiResponse({ status: HttpStatus.CREATED, type: LoginResponse })
  @ApiResponse({ status: HttpStatus.UNAUTHORIZED })
  @Post('/login')
  login(
    @Res() res,
    @Req() req,
    @Body() body: LoginRequest,
  ): Promise<LoginResponse> {
    return this.authService
      .login(body)
      .then((data) => res.json(data))
      .catch((e) => res.status(400).send(e.message));
  }

  @ApiResponse({ status: HttpStatus.CREATED, type: LoginResponse })
  @ApiResponse({ status: HttpStatus.UNAUTHORIZED })
  @Post('/register')
  register(
    @Res() res,
    @Req() req,
    @Body() body: RegisterRequest,
  ): Promise<LoginResponse> {
    return this.authService
      .register(body)
      .then((data) => res.json(data))
      .catch((e) => res.status(400).send(e.message));
  }
}
