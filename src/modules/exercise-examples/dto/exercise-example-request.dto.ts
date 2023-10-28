import {ApiProperty} from '@nestjs/swagger';

export class ExerciseExampleMuscleExerciseBundleRequestDto {
    id?: string;

    @ApiProperty({type: 'string', example: '3a975ded-af6b-4dd2-9a0e-6e3554e8e6dd'})
    muscleId: string;

    @ApiProperty({type: 'int', example: '20', description: 'percentage'})
    value: string;
}

export class ExerciseExampleRequestDto {
    id?: string;

    @ApiProperty({type: 'string', example: 'bench press'})
    name: string;

    @ApiProperty({type: [ExerciseExampleMuscleExerciseBundleRequestDto]})
    muscleExerciseBundles: ExerciseExampleMuscleExerciseBundleRequestDto[];
}