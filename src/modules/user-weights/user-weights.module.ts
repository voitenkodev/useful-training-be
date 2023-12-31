import { Module } from '@nestjs/common';
import { UserWeightsService } from './user-weights.service';
import { UserWeightsController } from './user-weights.controller';
import { repositoryProviders } from '../../database/repository.providers';
import { DatabaseModule } from '../../database/database.module';

@Module({
  imports: [DatabaseModule],
  providers: [UserWeightsService, ...repositoryProviders],
  controllers: [UserWeightsController]
})
export class UserWeightsModule {}
