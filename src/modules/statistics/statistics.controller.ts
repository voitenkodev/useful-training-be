import {Controller, Get, HttpStatus, Query, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {StatisticsService} from './statistics.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';

// todo 'trainings'
@Controller()
@ApiTags('statistics')
@ApiBearerAuth()
export class StatisticsController {
    constructor(private readonly statisticsService: StatisticsService) {
    }

    @Get("statistics/exercise")
    @UseGuards(JwtAuthGuard)
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getExerciseStatistics(@Req() req, @Res() res, @Query("id") id: string, @Query("limit") limit: number) {
        const user = req.user;
        return this.statisticsService
            .getExerciseStatistics(id, user, limit)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
