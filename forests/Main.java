package forests;

import java.io.*;
import java.util.*;


class Main {
    public static void main(String... args) throws IOException {
        String filename = args[0];
        Dataset data = new Dataset(filename);

        Dataset[] splitted = data.split(new double[] {0.8, 0.2});
        Dataset train = splitted[0];
        Dataset test = splitted[1];

        DecisionForest forest = new DecisionForest(train, 100, 7);

        int correct = 0;
        for (int i = 0; i < test.size; i++) {
            String prediction = forest.classify(test.data[i]);
            if (prediction.equals(test.labels[i])) {
                correct++;
            }
        }

        System.out.format("Correct: %d/%d\n", correct, data.size);
    }
}
