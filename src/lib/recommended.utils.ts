import {ExerciseExamplesEntity} from "../entities/exercise-examples.entity";

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
}