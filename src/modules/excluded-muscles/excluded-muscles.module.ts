import {Module} from '@nestjs/common';
import {ExcludedMusclesService} from './excluded-muscles.service';
import {ExcludedMusclesController} from './excluded-muscles.controller';
import {repositoryProviders} from '../../database/repository.providers';
import {DatabaseModule} from '../../database/database.module';

@Module({
    imports: [DatabaseModule],
    providers: [ExcludedMusclesService, ...repositoryProviders],
    controllers: [ExcludedMusclesController]
})
export class ExcludedMusclesModule {
}
