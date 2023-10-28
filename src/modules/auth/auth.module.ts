import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtService } from '@nestjs/jwt';
import { repositoryProviders } from '../../database/repository.providers';
import { DatabaseModule } from '../../database/database.module';
import { JwtStrategy } from './strategies/jwt.strategy';
import { PassportModule } from '@nestjs/passport';

@Module({
  imports: [
    DatabaseModule,
    PassportModule.register({
      defaultStrategy: ['jwt'],
    }),
  ],
  providers: [JwtStrategy, JwtService, AuthService, ...repositoryProviders],
  controllers: [AuthController],
  exports: [JwtStrategy, JwtService, AuthService, ...repositoryProviders],
})
export class AuthModule {}
