import {ApiProperty} from '@nestjs/swagger';

export class ExerciseExampleMuscleExerciseBundleRequestDto {
    id?: string;

    @ApiProperty({type: 'string', example: '3a975ded-af6b-4dd2-9a0e-6e3554e8e6dd'})
    muscleId: string;

    @ApiProperty({type: 'int', example: '20', description: 'percentage'})
    percentage: string;
}

export class ExerciseExampleRequestDto {
    id?: string;

    @ApiProperty({type: 'string', example: 'bench press'})
    name: string;

    @ApiProperty({type: 'string', example: 'The bench press is a compound strength-training...'})
    description: string;

    @ApiProperty({
        type: 'string',
        example: 'https://static.vecteezy.com/system/resources/thumbnails/022/653/711/small/treadmill-in-modern-gym-toned-image-3d-rendering-generative-ai-free-photo.jpg'
    })
    imageUrl: string;

    @ApiProperty({type: [ExerciseExampleMuscleExerciseBundleRequestDto]})
    muscleExerciseBundles: ExerciseExampleMuscleExerciseBundleRequestDto[];
}