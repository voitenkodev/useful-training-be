import {Controller, Get, HttpStatus, Query, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {StatisticsService} from './statistics.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';

// todo 'trainings'
@Controller('statistics')
@ApiTags('statistics')
@ApiBearerAuth()
export class StatisticsController {
    constructor(private readonly statisticsService: StatisticsService) {
    }

    @Get()
    @UseGuards(JwtAuthGuard)
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getAchievements(@Req() req, @Res() res, @Query("id") id: string) {
        const user = req.user;
        return this.statisticsService
            .getStatistics(id, user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
