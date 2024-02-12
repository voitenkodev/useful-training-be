import {Controller, Get, HttpStatus, Param, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {MusclesService} from './muscles.service';
import {JwtAuthGuard} from "../auth/guards/jwt-auth.guard";

@Controller()
@ApiTags('muscles')
export class MusclesController {
    constructor(private readonly musclesService: MusclesService) {
    }

    @Get("user-recommended.utils.ts")
    @UseGuards(JwtAuthGuard)
    @ApiBearerAuth()
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getUserMuscles(@Req() req, @Res() res) {
        const user = req.user
        return this.musclesService
            .getUserMuscles(user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }

    @Get('user-recommended.utils.ts/:id')
    @ApiBearerAuth()
    @UseGuards(JwtAuthGuard)
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getUserMuscleById(@Req() req, @Res() res, @Param('id') id: string) {
        const user = req.user
        return this.musclesService
            .getMuscleById(user, id)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }

    @Get("public-recommended.utils.ts")
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getMuscles(@Req() req, @Res() res) {
        return this.musclesService
            .getPublicMuscles()
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
