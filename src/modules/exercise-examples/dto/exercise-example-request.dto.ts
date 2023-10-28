import {ApiProperty} from '@nestjs/swagger';

export class ExerciseExampleMuscleExerciseBundleRequestDto {
    id?: string;

    @ApiProperty({type: 'string', example: ''})
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