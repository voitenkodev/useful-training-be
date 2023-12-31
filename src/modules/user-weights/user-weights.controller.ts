import {Controller, Get, HttpStatus, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiOperation, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {UserWeightsService} from './user-weights.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';

@Controller('user-weights')
@ApiTags('user-weights')
@ApiBearerAuth()
export class UserWeightsController {
    constructor(private readonly userWeightsService: UserWeightsService) {
    }

    @Get("")
    @UseGuards(JwtAuthGuard)
    @ApiOperation({summary: ``})
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getUserWeights(@Req() req, @Res() res) {
        const user = req.user;
        return this.userWeightsService
            .getUserWeights(user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
