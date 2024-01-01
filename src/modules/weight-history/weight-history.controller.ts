import {Controller, Get, HttpStatus, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiOperation, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {WeightHistoryService} from './weight-history.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';

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
}
