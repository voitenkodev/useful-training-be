import {Controller, Get, HttpStatus, Req, Res, UseGuards,} from '@nestjs/common';
import {ApiBearerAuth, ApiOperation, ApiResponse, ApiTags,} from '@nestjs/swagger';
import {UsersService} from './users.service';
import {JwtAuthGuard} from '../auth/guards/jwt-auth.guard';

@Controller('users')
@ApiTags('users')
@ApiBearerAuth()
export class UsersController {
    constructor(private readonly usersService: UsersService) {
    }

    @Get()
    @UseGuards(JwtAuthGuard)
    @ApiOperation({summary: ``})
    @ApiResponse({status: HttpStatus.UNAUTHORIZED, description: 'Unauthorized'})
    @ApiResponse({status: HttpStatus.FORBIDDEN, description: 'Forbidden'})
    getAllUsers(@Req() req, @Res() res) {
        return this.usersService
            .getAllUsers()
            .then((data) => res.json(data))
            .catch((err) => res.status(400).send(err.message));
    }
}
