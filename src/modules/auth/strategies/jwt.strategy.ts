import { Inject, Injectable, UnauthorizedException } from '@nestjs/common';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Repository } from 'typeorm';
import { UsersEntity } from '../../../entities/users.entity';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    @Inject('USERS_REPOSITORY')
    private usersRepository: Repository<UsersEntity>,
    private readonly configService: ConfigService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: configService.get('JWT_SECRET_KEY'),
    });
  }

  async validate(payload: any) {
    const timeDiff = payload.exp - payload.iat;
    if (timeDiff <= 0) {
      throw new UnauthorizedException();
    }
    const user = await this.usersRepository.findOne({
      where: { id: payload.id },
      select: ['id', 'email', 'password'],
    });
    if (!user) {
      throw new UnauthorizedException();
    }
    return user;
  }
}
