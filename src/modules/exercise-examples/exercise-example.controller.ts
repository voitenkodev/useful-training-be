import {Controller, Get, HttpStatus, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {ExerciseExampleService} from './exercise-example.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';

@Controller('exercise-examples')
@ApiTags('exercise-examples')
@ApiBearerAuth()
export class ExerciseExampleController {
    constructor(private readonly exerciseExamplesService: ExerciseExampleService) {
    }

    @Get()
    @UseGuards(JwtAuthGuard)
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getUserExerciseExamples(@Req() req, @Res() res) {
        const user = req.user;
        return this.exerciseExamplesService
            .getAllExerciseExamples(user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
