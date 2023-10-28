import {
  Body,
  Controller,
  Get,
  HttpStatus,
  Param,
  Post,
  Put,
  Req,
  Res,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { TrainingsService } from './trainings.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { TrainingsRequestDto } from './dto/trainings-request.dto';

@Controller('trainings')
@ApiTags('trainings')
@ApiBearerAuth()
export class TrainingsController {
  constructor(private readonly usersService: TrainingsService) {}

  @Get()
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: `abc` })
  @ApiResponse({ status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Forbidden' })
  getUserTrainings(@Req() req, @Res() res) {
    const user = req.user;
    return this.usersService
      .getAllTrainings(user)
      .then((data) => res.json(data))
      .catch((err) => res.status(400).send(err.message));
  }

  @Get(':id')
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: `abc` })
  @ApiResponse({ status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Forbidden' })
  getTrainingById(@Req() req, @Res() res, @Param('id') id: string) {
    const user = req.user;
    return this.usersService
      .getTrainingById(id, user)
      .then((data) => res.json(data))
      .catch((err) => res.status(400).send(err.message));
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: `abc` })
  @ApiResponse({ status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized' })
  @ApiResponse({ status: HttpStatus.FORBIDDEN, description: 'Forbidden' })
  setTraining(@Req() req, @Res() res, @Body() body: TrainingsRequestDto) {
    const user = req.user;
    return this.usersService
      .setOrUpdateTraining(body, user)
      .then((data) => res.json(data))
      .catch((err) => res.status(400).send(err.message));
  }
}
