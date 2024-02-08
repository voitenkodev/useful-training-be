import {Body, Controller, Get, HttpStatus, Param, Post, Query, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {ExerciseExampleService} from './exercise-example.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';
import {ExerciseExampleRequest} from "./dto/exercise-example.request";

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
    getExerciseExamples(
        @Req() req,
        @Res() res,
        @Query('size') size: number,
        @Query('page') page: number
    ) {
        const user = req.user;
        const {query, weightType, experience, forceType, category, muscleIds, equipmentIds} = req.query;

        return this.exerciseExamplesService
            .getExerciseExamples(
                user, page, size,
                {
                    query, weightType, experience, forceType, category,
                    muscleIds: muscleIds ? muscleIds.split(',') : [],
                    equipmentIds: equipmentIds ? equipmentIds.split(',') : []
                }
            ).then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }

    @Get('recommended')
    @UseGuards(JwtAuthGuard)
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getRecommendedExerciseExamples(@Req() req, @Res() res) {
        const user = req.user;
        return this.exerciseExamplesService
            .getRecommendedExerciseExamples(user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }

    @Get(':id')
    @UseGuards(JwtAuthGuard)
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getExerciseExampleById(@Req() req, @Res() res, @Param('id') id: string) {
        const user = req.user;
        return this.exerciseExamplesService
            .getExerciseExampleById(id, user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }

    @Post()
    @UseGuards(JwtAuthGuard)
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    setExerciseExample(@Req() req, @Res() res, @Body() body: ExerciseExampleRequest) {
        const user = req.user;
        return this.exerciseExamplesService
            .setOrUpdateExerciseExample(body, user)
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
