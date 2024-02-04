import {ApiProperty} from '@nestjs/swagger';
import {ExerciseCategoryEnum} from "../../../lib/exercise-category.enum";
import {WeightTypeEnum} from "../../../lib/weight-type.enum";
import {ExperienceEnum} from "../../../lib/experience.enum";
import {ForceTypeEnum} from "../../../lib/force-type.enum";

export class ExerciseExampleBundleRequest {
    id?: string;

    @ApiProperty({type: 'string', example: '3a975ded-af6b-4dd2-9a0e-6e3554e8e6dd'})
    muscleId: string;

    @ApiProperty({type: 'int', example: '20', description: 'percentage'})
    percentage: string;
}

export class ExerciseExampleRequest {
    id?: string;

    @ApiProperty({type: 'string', example: 'bench press'})
    name: string;

    @ApiProperty({type: 'string', example: 'The bench press is a compound strength-training...'})
    description: string;

    @ApiProperty({type: 'string', example: WeightTypeEnum.Fixed})
    weightType: string;

    @ApiProperty({type: 'string', example: ExerciseCategoryEnum.Compound})
    category: ExerciseCategoryEnum;

    @ApiProperty({type: 'string', example: ExperienceEnum.PRO})
    experience: ExperienceEnum;

    @ApiProperty({type: 'string', example: ForceTypeEnum.PUSH})
    forceType: ForceTypeEnum;

    @ApiProperty({
        type: 'string',
        example: 'https://static.vecteezy.com/system/resources/thumbnails/022/653/711/small/treadmill-in-modern-gym-toned-image-3d-rendering-generative-ai-free-photo.jpg'
    })
    imageUrl: string;

    @ApiProperty({type: [ExerciseExampleBundleRequest]})
    exerciseExampleBundles: ExerciseExampleBundleRequest[];

    @ApiProperty({
        example: ['9896a0c5-0de2-42de-a274-0e3695b1accf'],
        type: 'list',
        description: 'excluded equipment ids'
    })
    excludeEquipmentIds: string[];
}