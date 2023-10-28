import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { UsersModule } from './modules/users/users.module';
import { DatabaseModule } from './database/database.module';
import { AuthModule } from './modules/auth/auth.module';
import { TrainingsModule } from './modules/trainings/trainings.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: `.env`,
      isGlobal: true,
    }),
    DatabaseModule,
    AuthModule,
    UsersModule,
    TrainingsModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
