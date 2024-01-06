import {Module} from '@nestjs/common';
import {ConfigModule} from '@nestjs/config';
import {UsersModule} from './modules/users/users.module';
import {DatabaseModule} from './database/database.module';
import {AuthModule} from './modules/auth/auth.module';
import {TrainingsModule} from './modules/trainings/trainings.module';
import {ExerciseExampleModule} from "./modules/exercise-examples/exercise-example.module";
import {MusclesModule} from "./modules/muscles/muscles.module";
import {WeightHistoryModule} from "./modules/weight-history/weight-history.module";
import {StatisticsModule} from "./modules/statistics/statistics.module";
import {ExcludedMusclesModule} from "./modules/excluded-muscles/excluded-muscles.module";
import {EquipmentsModule} from "./modules/equipments/equipments.module";
import {ExcludedEquipmentsModule} from "./modules/excluded-equipments/excluded-equipments.module";

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
        StatisticsModule,
        WeightHistoryModule,
        ExcludedMusclesModule,
        ExcludedEquipmentsModule,
        EquipmentsModule,
        ExerciseExampleModule,
        MusclesModule
    ],
    controllers: [],
    providers: [],
})
export class AppModule {
}
