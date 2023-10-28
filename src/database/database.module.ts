import { Module } from '@nestjs/common';
import { databaseProviders } from './database.provider';
import { ConfigModule } from '@nestjs/config';
import { DatabaseService } from './database.service';

@Module({
  imports: [ConfigModule.forRoot()],
  providers: [...databaseProviders, DatabaseService],
  exports: [...databaseProviders],
})
export class DatabaseModule {}
