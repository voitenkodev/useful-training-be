import { SnakeNamingStrategy } from './snake-naming.strategy';
import { DataSourceOptions } from 'typeorm';
import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class DatabaseService {
  constructor(private configService: ConfigService) {}

  typeOrmConfig(): DataSourceOptions {
    const entities = [`${__dirname}/../entities/*.entity{.ts,.js}`];

    return {
      entities,
      migrations: [],
      name: 'default',
      type: 'postgres',
      synchronize: this.configService.get('POSTGRES_SYNC') === 'true',
      logging: this.configService.get('POSTGRES_LOGS') === 'true',
      namingStrategy: new SnakeNamingStrategy(),
      migrationsRun: this.configService.get('POSTGRES_MIGRATIONS') === 'true',
      host: this.configService.get('POSTGRES_HOST'),
      port: Number(this.configService.get('POSTGRES_PORT')),
      username: this.configService.get('POSTGRES_USERNAME'),
      database: this.configService.get('POSTGRES_DATABASE'),
      password: this.configService.get('POSTGRES_PASSWORD'),
      extra: {
        charset: 'utf8mb4_unicode_ci',
      },
    };
  }
}
