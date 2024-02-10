import {Body, Controller, Get, HttpStatus, Param, Post, Query, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiQuery, ApiResponse, ApiTags,} from '@nestjs/swagger';
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
    @ApiQuery({name: 'query', required: false})
    @ApiQuery({name: 'weightType', required: false})
    @ApiQuery({name: 'experience', required: false})
    @ApiQuery({name: 'forceType', required: false})
    @ApiQuery({name: 'category', required: false})
    @ApiQuery({name: 'muscleIds', required: false})
    @ApiQuery({name: 'equipmentIds', required: false})
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getExerciseExamples(
        @Req() req,
        @Res() res,
        @Query('size') size: number,
        @Query('page') page: number,
        @Query('query') query: string,
        @Query('weightType') weightType: string,
        @Query('experience') experience: string,
        @Query('forceType') forceType: string,
        @Query('category') category: string,
        @Query('muscleIds') muscleIds: string,
        @Query('equipmentIds') equipmentIds: string,
    ) {
        const user = req.user;

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
    @ApiQuery({name: 'exerciseCount', required: false})
    @ApiQuery({name: 'exerciseExampleIds', required: false})
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getRecommendedExerciseExamples(
        @Req() req,
        @Res() res,
        @Query('size') size: number,
        @Query('page') page: number,
        @Query('exerciseCount') exerciseCount: number,
        @Query('exerciseExampleIds') exerciseExampleIds: string
    ) {
        const user = req.user;
        return this.exerciseExamplesService
            .getRecommendedExerciseExamples(
                user, page, size,
                {
                    exerciseCount, exerciseExampleIds
                }
            )
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
