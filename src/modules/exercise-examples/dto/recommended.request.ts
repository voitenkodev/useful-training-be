import {ApiProperty} from '@nestjs/swagger';

export class RecommendedRequest {

    @ApiProperty({type: 'string', example: null})
    targetMuscleId: string;

    @ApiProperty({type: 'int', example: '1', description: 'current exercise count'})
    exerciseCount: number;

    @ApiProperty({example: []})
    exerciseExampleIds: string[];
}

