import { DataSource } from 'typeorm';
import { DatabaseService } from './database.service';

export const databaseProviders = [
  {
    provide: 'DATA_SOURCE',
    useFactory: async (databaseService: DatabaseService) => {
      const dataSource = new DataSource(databaseService.typeOrmConfig());

      return dataSource.initialize();
    },
    inject: [DatabaseService],
  },
];
