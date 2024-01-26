import {BadRequestException, Inject, Injectable, UnauthorizedException} from '@nestjs/common';
import {Repository} from 'typeorm';
import {UsersEntity} from '../../entities/users.entity';
import {LoginResponse} from './dto/login.response';
import {LoginRequest} from './dto/login.request';
import {JwtService, JwtSignOptions} from '@nestjs/jwt';
import {Hash} from '../../lib/hash';
import {ConfigService} from '@nestjs/config';
import {RegisterRequest} from "./dto/register.request";
import {WeightHistoryEntity} from "../../entities/weight-history.entity";
import {ExcludedMusclesEntity} from "../../entities/excluded-muscles.entity";
import {ExcludedEquipmentsEntity} from "../../entities/excluded-equipments.entity";

@Injectable()
export class AuthService {
    private readonly jwtOptions: JwtSignOptions;
    private readonly jwtKey: string;
    private readonly expiresInDefault: string | number;

    constructor(
        public readonly configService: ConfigService,
        private readonly jwtService: JwtService,
        @Inject('USERS_REPOSITORY')
        private usersRepository: Repository<UsersEntity>,
        @Inject('WEIGHT_HISTORY_REPOSITORY')
        private weightHistoryRepository: Repository<UsersEntity>,
        @Inject('EXCLUDED_MUSCLES_REPOSITORY')
        private excludedMusclesEntity: Repository<ExcludedMusclesEntity>,
        @Inject('EXCLUDED_EQUIPMENTS_REPOSITORY')
        private readonly excludedEquipmentsRepository: Repository<ExcludedEquipmentsEntity>,
    ) {
        this.expiresInDefault = parseInt(configService.get('JWT_EXPIRATION_TIME'), 10) || 60 * 5;
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

        const userEntity = new UsersEntity();
        userEntity.email = body.email;
        userEntity.name = body.name;
        userEntity.height = body.height;
        userEntity.experience = body.experience;
        userEntity.password = Hash.make(body.password);

        const user = await this.usersRepository.save(userEntity);

        const weightEntity = new WeightHistoryEntity();
        weightEntity.userId = user.id
        weightEntity.weight = body.weight

        await this.weightHistoryRepository.save(weightEntity);

        const excludedMuscleEntities = body.excludeMuscleIds.map((r) => {
            const entity = new ExcludedMusclesEntity();
            entity.muscleId = r
            entity.userId = user.id
            return entity
        })

        await this.excludedMusclesEntity.save(excludedMuscleEntities)

        const excludedEquipmentEntities = body.excludeEquipmentIds.map((r) => {
            const entity = new ExcludedEquipmentsEntity();
            entity.equipmentId = r
            entity.userId = user.id
            return entity
        })

        await this.excludedEquipmentsRepository.save(excludedEquipmentEntities)

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
