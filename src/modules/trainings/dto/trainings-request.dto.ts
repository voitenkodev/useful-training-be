import { ApiProperty } from '@nestjs/swagger';

export class ExerciseIterationRequestDto {
  id?: string;

  @ApiProperty({ type: 'float', example: 100.5, description: 'kg' })
  weight: number;

  @ApiProperty({ type: 'number', example: 100, description: 'kg' })
  repeat: number;
}

export class TrainingExerciseRequestDto {
  id?: string;

  @ApiProperty({ type: 'string', example: 'bench press' })
  name: string;

  @ApiProperty({ type: 'number', example: 2000, description: 'kg' })
  tonnage: number;

  @ApiProperty({ type: 'number', example: 50 })
  countOfLifting: number;

  @ApiProperty({ type: 'number', example: 60, description: 'percentage' })
  intensity: number;

  @ApiProperty({ type: [ExerciseIterationRequestDto] })
  iterations: ExerciseIterationRequestDto[];
}

export class TrainingsRequestDto {
  id?: string;

  @ApiProperty({ type: 'number', example: 25, description: 'minutes' })
  durations: number;

  @ApiProperty({ type: 'number', example: 20000, description: 'kg' })
  tonnage: number;

  @ApiProperty({ type: 'number', example: 150 })
  countOfLifting: number;

  @ApiProperty({ type: 'number', example: 60, description: 'percentage' })
  intensity: number;

  @ApiProperty({ example: new Date() })
  date: Date;

  @ApiProperty({ type: [TrainingExerciseRequestDto] })
  exercises: TrainingExerciseRequestDto[];
}
