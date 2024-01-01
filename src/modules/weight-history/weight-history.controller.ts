import {Body, Controller, Get, HttpStatus, Post, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiOperation, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {WeightHistoryService} from './weight-history.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';
import {ExerciseExampleRequest} from "../exercise-examples/dto/exercise-example.request";
import {WeightHistoryEntity} from "../../entities/weight-history.entity";
import {WeightHistoryRequest} from "./dto/weight-history.request";

@Controller('weight-history')
@ApiTags('weight-history')
@ApiBearerAuth()
export class WeightHistoryController {
    constructor(private readonly weightHistoryService: WeightHistoryService) {
    }

    @Get("")
    @UseGuards(JwtAuthGuard)
    @ApiOperation({summary: ``})
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getWeightHistory(@Req() req, @Res() res) {
        const user = req.user;
        return this.weightHistoryService
            .getWeightHistory(user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }

    @Post("")
    @UseGuards(JwtAuthGuard)
    @ApiOperation({summary: ``})
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    setWeightHistory(@Req() req, @Res() res,  @Body() body: WeightHistoryRequest) {
        const user = req.user;
        return this.weightHistoryService
            .setWeightHistory(user, body.weight)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
