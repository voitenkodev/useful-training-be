import {BadRequestException, Inject, Injectable, Logger, UnauthorizedException,} from '@nestjs/common';
import {Repository} from 'typeorm';
import {UsersEntity} from '../../entities/users.entity';
import {LoginResponse} from './dto/login.response';
import {LoginRequest} from './dto/login.request';
import {JwtService, JwtSignOptions} from '@nestjs/jwt';
import {Hash} from '../../lib/hash';
import {ConfigService} from '@nestjs/config';
import {RegisterRequest} from "./dto/register.request";

@Injectable()
export class AuthService {
    private readonly logger = new Logger(AuthService.name);
    private readonly jwtOptions: JwtSignOptions;
    private readonly jwtKey: string;
    private readonly expiresInDefault: string | number;

    constructor(
        public readonly configService: ConfigService,
        private readonly jwtService: JwtService,
        @Inject('USERS_REPOSITORY')
        private usersRepository: Repository<UsersEntity>,
    ) {
        this.expiresInDefault =
            parseInt(configService.get('JWT_EXPIRATION_TIME'), 10) || 60 * 5;
        this.jwtKey = configService.get('JWT_SECRET_KEY');
        this.jwtOptions = {secret: this.jwtKey, expiresIn: this.expiresInDefault};
    }

    async login(body: LoginRequest): Promise<LoginResponse> {
        const user = await this.usersRepository.findOne({
            where: {email: body.email},
            select: ['id', 'email', 'password'],
        });

        if (!user) {
            throw new UnauthorizedException();
        }
        if (!Hash.compare(body.password, user.password)) {
            throw new UnauthorizedException('Invalid credentials!');
        }
        const accessToken = await this.createAccessToken(user.id);

        return {
            id: user.id,
            accessToken,
        };
    }

    async register(body: RegisterRequest): Promise<LoginResponse> {
        const existUser = await this.usersRepository.findOne({
            where: {email: body.email}
        });

        if (existUser) {
            throw new BadRequestException('This email already taken');
        }

        const entity = new UsersEntity();
        entity.email = body.email;
        entity.name = body.name;
        entity.weight = body.weight;
        entity.height = body.height;
        entity.password = Hash.make(body.password);

        const user = await this.usersRepository.save(entity);

        const accessToken = await this.createAccessToken(user.id);

        return {
            id: user.id,
            accessToken
        };
    }

    async createAccessToken(userId: string): Promise<string> {
        const findUser = await this.usersRepository.findOne({
            where: {id: userId},
        });
        const payload = {
            id: findUser.id
        };

        return this.jwtService.sign(payload, this.jwtOptions);
    }
}
