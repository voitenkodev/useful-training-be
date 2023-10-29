import {BadRequestException, Inject, Injectable } from '@nestjs/common';
import { UsersEntity } from '../../entities/users.entity';
import { v4 } from 'uuid';
import { Repository } from 'typeorm';
import { TrainingsRequestDto } from './dto/trainings-request.dto';
import { TrainingsEntity } from '../../entities/trainings.entity';
import { ExercisesEntity } from '../../entities/exercises.entity';
import { IterationsEntity } from '../../entities/iterations.entity';
import * as moment from 'moment'

@Injectable()
export class TrainingsService {
  constructor(
    @Inject('USERS_REPOSITORY')
    private readonly usersRepository: Repository<UsersEntity>,
    @Inject('TRAININGS_REPOSITORY')
    private readonly trainingsRepository: Repository<TrainingsEntity>,
    @Inject('EXERCISES_REPOSITORY')
    private readonly exercisesRepository: Repository<ExercisesEntity>,
    @Inject('ITERATIONS_REPOSITORY')
    private readonly iterationsRepository: Repository<IterationsEntity>,
  ) {}

  async getAllTrainings(user, start, end) {
    if(!moment(start).isValid() || !moment(end).isValid()) {
      throw new BadRequestException('Wrong date format')
    }

    return this.trainingsRepository
      .createQueryBuilder('trainings')
      .where('trainings.userId = :userId', { userId: user.id })
      .andWhere('date(:start) <= date(trainings.createdAt) and date(:end) >= date(trainings.createdAt)', {start, end})
      .leftJoinAndSelect('trainings.exercises', 'exercises')
      .leftJoinAndSelect('exercises.iterations', 'iterations')
      .addOrderBy('trainings.createdAt', 'DESC')
      .getMany();
  }

  async getTrainingById(id: string, user) {
    return this.trainingsRepository
      .createQueryBuilder('trainings')
      .where('trainings.id = :id', { id })
      .andWhere('trainings.userId = :userId', { userId: user.id })
      .leftJoinAndSelect('trainings.exercises', 'exercises')
      .leftJoinAndSelect('exercises.iterations', 'iterations')
      .addOrderBy('trainings.createdAt', 'DESC')
      .getOne();
  }

  async setOrUpdateTraining(body: TrainingsRequestDto, user) {
    const { exercises, ...rest } = body;

    const training = new TrainingsEntity();
    Object.assign(training, rest);
    training.id = !training.id ? v4() : training.id;
    training.userId = user.id;

    const exercisesEntities = [];
    const iterationEntities = [];

    exercises.forEach((el) => {
      const { iterations, ...reqExercise } = el;
      const exerciseEntity = new ExercisesEntity();
      Object.assign(exerciseEntity, reqExercise);
      exerciseEntity.id = !exerciseEntity.id ? v4() : exerciseEntity.id;
      exerciseEntity.trainingId = training.id;

      exercisesEntities.push(exerciseEntity);

      iterations.forEach((iter) => {
        const iterationEntity = new IterationsEntity();
        Object.assign(iterationEntity, iter);
        iterationEntity.id = !iterationEntity.id ? v4() : iterationEntity.id;
        iterationEntity.exerciseId = exerciseEntity.id;
        iterationEntities.push(iterationEntity);
      });
    });

    await this.trainingsRepository.save(training);
    await this.exercisesRepository.save(exercisesEntities);
    await this.iterationsRepository.save(iterationEntities);

    return this.getTrainingById(training.id, user);
  }
}
