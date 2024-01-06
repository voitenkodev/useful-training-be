import {Inject, Injectable} from '@nestjs/common';
import {Repository} from 'typeorm';
import {EquipmentResponse, EquipmentTypeResponse} from "./dto/equipment-response";
import {ExcludedEquipmentsEntity} from "../../entities/excluded-equipments.entity";
import {EquipmentTypesEntity} from "../../entities/equipment-types.entity";
import {EquipmentsEntity} from "../../entities/equipments.entity";
import {EquipmentStatusEnum} from "../../lib/equipment-status.enum";

@Injectable()
export class EquipmentsService {
    constructor(
        @Inject('EQUIPMENTS_REPOSITORY')
        private readonly equipmentsRepository: Repository<EquipmentsEntity>,
        @Inject('EQUIPMENT_TYPES_REPOSITORY')
        private readonly equipmentTypesRepository: Repository<EquipmentTypesEntity>,
        @Inject('EXCLUDED_EQUIPMENTS_REPOSITORY')
        private readonly excludedEquipmentsRepository: Repository<ExcludedEquipmentsEntity>,
    ) {
    }

    async getUserEquipments(user) {
        const equipmentTypes = await this.equipmentTypesRepository
            .createQueryBuilder('equipment_types')
            .leftJoinAndSelect('equipment_types.equipments', 'equipments')
            .getMany();

        const excluded = await this.excludedEquipmentsRepository
            .createQueryBuilder('excluded_equipments')
            .where('excluded_equipments.userId = :userId', {userId: user.id})
            .select(['excluded_equipments.equipmentId'])
            .getMany();

        return equipmentTypes.map((item) => {
                const equipmentType = new EquipmentTypeResponse()
                equipmentType.id = item.id
                equipmentType.name = item.name
                equipmentType.type = item.type
                equipmentType.createdAt = item.createdAt
                equipmentType.updatedAt = item.updatedAt
                equipmentType.equipments = item.equipments.map((equipment) => {
                        return this.processingEquipment(user, equipment, excluded)
                    }
                )
                return equipmentType
            }
        )
    }

    async getPublicEquipments() {
        const equipmentTypes = await this.equipmentTypesRepository
            .createQueryBuilder('equipment_types')
            .leftJoinAndSelect('equipment_types.equipments', 'equipments')
            .getMany();

        return equipmentTypes.map((item) => {
                const equipmentType = new EquipmentTypeResponse()
                equipmentType.id = item.id
                equipmentType.name = item.name
                equipmentType.type = item.type
                equipmentType.createdAt = item.createdAt
                equipmentType.updatedAt = item.updatedAt
                equipmentType.equipments = item.equipments.map((equipment) => {
                        const response = new EquipmentResponse()
                        response.id = equipment.id
                        response.name = equipment.name
                        response.type = equipment.type
                        response.equipmentTypeId = equipment.equipmentTypeId
                        response.createdAt = equipment.createdAt
                        response.updatedAt = equipment.updatedAt
                        return response
                    }
                )
                return equipmentType
            }
        )
    }

    private processingEquipment(user, equipment, excluded) {
        let status: EquipmentStatusEnum = null

        if (user) {
            if (excluded.some((excludedItem) => excludedItem.equipmentId === equipment.id)) {
                status = EquipmentStatusEnum.EXCLUDED
            } else {
                status = EquipmentStatusEnum.INCLUDED
            }
        }

        const response = new EquipmentResponse()
        response.id = equipment.id
        response.name = equipment.name
        response.type = equipment.type
        response.equipmentTypeId = equipment.equipmentTypeId
        response.status = status
        response.createdAt = equipment.createdAt
        response.updatedAt = equipment.updatedAt
        return response
    }
}
