import {Module} from '@nestjs/common';
import {ExcludedEquipmentsService} from './excluded-equipments.service';
import {ExcludedEquipmentsController} from './excluded-equipments.controller';
import {repositoryProviders} from '../../database/repository.providers';
import {DatabaseModule} from '../../database/database.module';

@Module({
    imports: [DatabaseModule],
    providers: [ExcludedEquipmentsService, ...repositoryProviders],
    controllers: [ExcludedEquipmentsController]
})
export class ExcludedEquipmentsModule {
}
