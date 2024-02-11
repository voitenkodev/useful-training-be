import {ApiProperty} from '@nestjs/swagger';
import {WeightTypeEnum} from "../../../lib/weight-type.enum";
import {ExperienceEnum} from "../../../lib/experience.enum";
import {ForceTypeEnum} from "../../../lib/force-type.enum";
import {ExerciseCategoryEnum} from "../../../lib/exercise-category.enum";

export class FiltersRequest {

    @ApiProperty({type: 'string', example: ''})
    query: string;

    @ApiProperty({type: "string", example: WeightTypeEnum.Free})
    weightType: WeightTypeEnum;

    @ApiProperty({type: "string", example: ExperienceEnum.BEGINNER,})
    experience: ExperienceEnum;

    @ApiProperty({type: "string", example: ForceTypeEnum.PUSH})
    forceType: ForceTypeEnum;

    @ApiProperty({type: "string", example: ExerciseCategoryEnum.Isolation})
    category: ExerciseCategoryEnum;

    @ApiProperty()
    muscleIds: string[];

    @ApiProperty()
    equipmentIds: string[];
}

