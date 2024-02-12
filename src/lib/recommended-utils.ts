import {ExerciseExamplesEntity} from "../entities/exercise-examples.entity";
import {ExperienceEnum} from "./experience.enum";

export class RecommendedUtils {

    // Get count of last exercise examples with the same muscle target
    static countOfLastMuscleTargetExercises(exerciseExamples: ExerciseExamplesEntity[]) {

        if (!exerciseExamples || exerciseExamples.length == 0) {
            return 0
        }

        const target = exerciseExamples.map((item) =>
            item.exerciseExampleBundles.reduce((maxBundle, bundle) =>
                bundle.percentage > maxBundle.percentage ? bundle : maxBundle, item.exerciseExampleBundles[0])
        );

        if (!target || target.length == 0) {
            return 0
        }

        const idCounts = target.reduceRight((counts, muscle) => {
            counts[muscle.id] = (counts[muscle.id] || 0) + 1;
            return counts;
        }, {});

        return Object.values(idCounts).length;
    }

    static minMaxTrainingExercisesByExp(experience: ExperienceEnum) {
        switch (experience) {
            case ExperienceEnum.BEGINNER: {
                return [3, 6]
            }
            case ExperienceEnum.INTERMEDIATE: {
                return [4, 8]
            }
            case ExperienceEnum.ADVANCED: {
                return [6, 10]
            }
            case ExperienceEnum.PRO: {
                return [8, 12]
            }
        }
    }

    static minMaxMuscleExercisesByExp(experience: ExperienceEnum) {
        switch (experience) {
            case ExperienceEnum.BEGINNER: {
                return [1, 2]
            }
            case ExperienceEnum.INTERMEDIATE: {
                return [2, 3]
            }
            case ExperienceEnum.ADVANCED: {
                return [3, 4]
            }
            case ExperienceEnum.PRO: {
                return [4, 5]
            }
        }
    }
}