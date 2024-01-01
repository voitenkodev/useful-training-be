import {ApiProperty} from "@nestjs/swagger";

export class WeightHistoryRequest {

    @ApiProperty({type: 'int', example: '444', description: 'weight'})
    weight: number;
}
