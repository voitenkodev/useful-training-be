import {Controller, Get, HttpStatus, Param, Req, Res,} from '@nestjs/common';
import {ApiResponse, ApiTags,} from '@nestjs/swagger';
import {MusclesService} from './muscles.service';

@Controller('muscles')
@ApiTags('muscles')
export class MusclesController {
    constructor(private readonly musclesService: MusclesService) {
    }

    @Get()
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getMuscles(@Req() req, @Res() res) {
        const user = req.user
        return this.musclesService
            .getMuscles(user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }

    @Get(':id')
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getMuscleById(@Req() req, @Res() res, @Param('id') id: string) {
        const user = req.user
        return this.musclesService
            .getMuscleById(user, id)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
