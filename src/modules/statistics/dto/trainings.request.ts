import {ApiProperty} from '@nestjs/swagger';
import {ExerciseExampleRequest} from "../../exercise-examples/dto/exercise-example.request";

export class ExerciseIterationRequest {
    id?: string;

    @ApiProperty({type: 'double', example: 100.5, description: 'kg'})
    weight: number;

    @ApiProperty({type: 'number', example: 10})
    repetitions: number;
}

export class TrainingExerciseRequest {
    id?: string;

    @ApiProperty({type: 'string', example: 'bench press'})
    name: string;

    @ApiProperty({type: 'double', example: 2000.5, description: 'kg'})
    volume: number;

    @ApiProperty({type: 'number', example: 50})
    repetitions: number;

    @ApiProperty({type: 'double', example: 60, description: 'percentage'})
    intensity: number;

    @ApiProperty({type: [ExerciseIterationRequest]})
    iterations: ExerciseIterationRequest[];

    @ApiProperty({type: [ExerciseExampleRequest]})
    exerciseExample: ExerciseExampleRequest[];
}

export class TrainingsRequest {
    id?: string;

    @ApiProperty({type: 'number', example: 25, description: 'minutes'})
    duration: number;

    @ApiProperty({type: 'double', example: 20000.5, description: 'kg'})
    volume: number;

    @ApiProperty({type: 'number', example: 150})
    repetitions: number;

    @ApiProperty({type: 'number', example: 60, description: 'percentage'})
    intensity: number;

    @ApiProperty({type: [TrainingExerciseRequest]})
    exercises: TrainingExerciseRequest[];
}
