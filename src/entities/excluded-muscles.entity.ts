import {
    Column,
    CreateDateColumn,
    Entity, JoinColumn,
    ManyToOne,
    OneToMany,
    PrimaryGeneratedColumn,
    UpdateDateColumn,
} from 'typeorm';
import {MusclesEntity} from "./muscles.entity";
import {UsersEntity} from "./users.entity";

@Entity({name: 'excluded_muscles'})
export class ExcludedMusclesEntity {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({default: null})
    muscleId: string;

    @CreateDateColumn({
        type: 'timestamp without time zone',
        name: 'created_at',
    })
    createdAt: Date;

    @Column({ default: null })
    userId: string;

    @UpdateDateColumn({
        type: 'timestamp without time zone',
        name: 'updated_at',
    })
    updatedAt: Date;

    @ManyToOne(() => MusclesEntity, (muscle) => muscle.excludedMuscles, {
        onDelete: 'CASCADE',
        orphanedRowAction: 'delete',
    })
    @JoinColumn({name: 'muscle_id'})
    muscle: MusclesEntity;

    @ManyToOne(() => UsersEntity, (user) => user.trainings, {
        onDelete: 'CASCADE',
        orphanedRowAction: 'delete',
    })
    @JoinColumn({ name: 'user_id' })
    user: UsersEntity;
}
