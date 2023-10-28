import {ApiProperty} from '@nestjs/swagger';

export class MuscleExerciseBundleMuscleRequestDto {
    id?: string;

    @ApiProperty({type: 'string', example: 'biceps'})
    name: string;
}

export class ExerciseExampleMuscleExerciseBundleRequestDto {
    id?: string;

    muscle?: MuscleExerciseBundleMuscleRequestDto;

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