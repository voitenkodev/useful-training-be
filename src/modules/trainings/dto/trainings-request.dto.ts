import { ApiProperty } from '@nestjs/swagger';

export class ExerciseIterationRequestDto {
  id?: string;

  @ApiProperty({ type: 'double', example: 100.5, description: 'kg' })
  weight: number;

  @ApiProperty({ type: 'number', example: 10 })
  repeat: number;
}

export class TrainingExerciseRequestDto {
  id?: string;

  @ApiProperty({ type: 'string', example: 'bench press' })
  name: string;

  @ApiProperty({ type: 'double', example: 2000.0, description: 'kg' })
  tonnage: number;

  @ApiProperty({ type: 'number', example: 50 })
  countOfLifting: number;

  @ApiProperty({ type: 'double', example: 60, description: 'percentage' })
  intensity: number;

  @ApiProperty({ type: [ExerciseIterationRequestDto] })
  iterations: ExerciseIterationRequestDto[];
}

export class TrainingsRequestDto {
  id?: string;

  @ApiProperty({ type: 'number', example: 25, description: 'minutes' })
  durations: number;

  @ApiProperty({ type: 'double', example: 20000.0, description: 'kg' })
  tonnage: number;

  @ApiProperty({ type: 'number', example: 150 })
  countOfLifting: number;

  @ApiProperty({ type: 'number', example: 60, description: 'percentage' })
  intensity: number;

  @ApiProperty({ type: [TrainingExerciseRequestDto] })
  exercises: TrainingExerciseRequestDto[];
}
