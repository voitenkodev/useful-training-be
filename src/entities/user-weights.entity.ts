import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryGeneratedColumn,
    UpdateDateColumn,
} from 'typeorm';
import {UsersEntity} from "./users.entity";

@Entity({name: 'user_weights'})
export class UserWeightsEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    userId: string;

    @Column({type: 'double precision'})
    weight: number;

    @CreateDateColumn({type: 'timestamp without time zone', name: 'created_at'})
    createdAt: Date;

    @UpdateDateColumn({type: 'timestamp without time zone', name: 'updated_at'})
    updatedAt: Date;

    @ManyToOne(() => UsersEntity, (user) => user.weights, {
        onDelete: 'CASCADE',
        orphanedRowAction: 'delete',
    })
    @JoinColumn({name: 'user_id'})
    user: UsersEntity;
}
