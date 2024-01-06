import {BadRequestException, Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {EquipmentsEntity} from "../../entities/equipments.entity";
import {ExcludedEquipmentsEntity} from "../../entities/excluded-equipments.entity";

@Injectable()
export class ExcludedEquipmentsService {
    constructor(
        @Inject('EQUIPMENTS_REPOSITORY')
        private readonly equipmentsRepository: Repository<EquipmentsEntity>,
        @Inject('EXCLUDED_EQUIPMENTS_REPOSITORY')
        private readonly excludedEquipmentsRepository: Repository<ExcludedEquipmentsEntity>,
    ) {
    }

    async getExcludedEquipments(user) {
        return await this.excludedEquipmentsRepository
            .createQueryBuilder('excluded_equipments')
            .where('excluded_equipments.userId = :userId', {userId: user.id})
            .getMany()
    }

    async setExcludedEquipment(user, id: string) {
        const excludedEquipment = await this.excludedEquipmentsRepository
            .createQueryBuilder('excluded_equipments')
            .where('excluded_equipments.userId = :userId', {userId: user.id})
            .andWhere('excluded_equipments.equipmentId = :equipmentId', {equipmentId: id})
            .getOne();

        if (excludedEquipment != null) {
            throw new BadRequestException('This equipment already excluded');
        }

        const equipment = await this.equipmentsRepository
            .createQueryBuilder("equipments")
            .where('equipments.id = :id', {id: id})
            .getOne();

        if (equipment == null) {
            throw new BadRequestException('Unknown equipment');
        }

        const excludedEquipmentEntity = new ExcludedEquipmentsEntity()
        excludedEquipmentEntity.equipmentId = id
        excludedEquipmentEntity.userId = user.id

        return await this.excludedEquipmentsRepository.save(excludedEquipmentEntity)
    }

    async deleteExcludedEquipment(user, id: string) {
        const excludedEquipment = await this.excludedEquipmentsRepository
            .createQueryBuilder('excluded_equipments')
            .where('excluded_equipments.userId = :userId', {userId: user.id})
            .andWhere('excluded_equipments.equipmentId = :equipmentId', {equipmentId: id})
            .getOne();

        if (excludedEquipment == null) {
            throw new BadRequestException('This equipment is not excluded');
        }

        return await this.excludedEquipmentsRepository.remove(excludedEquipment)
    }
}
