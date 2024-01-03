import {Controller, Delete, HttpStatus, Param, Post, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiOperation, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {ExcludedMusclesService} from './excluded-muscles.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';

@Controller('excluded-muscles')
@ApiTags('excluded-muscles')
@ApiBearerAuth()
export class ExcludedMusclesController {
    constructor(private readonly excludedMusclesService: ExcludedMusclesService) {
    }

    @Post()
    @UseGuards(JwtAuthGuard)
    @ApiOperation({summary: ``})
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    setExcludedMuscle(@Req() req, @Res() res, @Param('id') id: string) {
        const user = req.user;
        return this.excludedMusclesService
            .setExcludedMuscle(user, id)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }

    @Delete()
    @UseGuards(JwtAuthGuard)
    @ApiOperation({summary: ``})
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    deleteExcludedMuscle(@Req() req, @Res() res, @Param('id') id: string) {
        const user = req.user;
        return this.excludedMusclesService
            .deleteExcludedMuscle(user, id)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
