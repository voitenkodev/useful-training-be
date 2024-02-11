import {ApiProperty} from '@nestjs/swagger';

export class RecommendedRequest {

    @ApiProperty({type: 'string', example: '3a975ded-af6b-4dd2-9a0e-6e3554e8e6dd'})
    targetMuscleId: string;

    @ApiProperty({type: 'int', example: '1', description: 'current exercise count'})
    exerciseCount: number;

    @ApiProperty()
    exerciseExampleIds: string[];
}

