clear java;
javaaddpath([pwd '/forests.jar']);
import forests.*;

test_percents = []; train_percents = [];

% Test different radii.
dataset_sizes = [50 100 150 200 300 500 750 1000 1400];
radius = 10;
num_trees = 35;
num_attributes = 30;

for datasize = dataset_sizes
    disp(sprintf('Testing data size %d.', datasize));
    [vectors, classes] = load_keypoints(datasize, radius);
    data = forests.Dataset(vectors', classes);
    splitted = data.split([0.9 0.1]);
    training = splitted(1);
    test = splitted(2);

    forest = forests.DecisionForest(training, num_trees, num_attributes);
    test_percents = [test_percents, forest.evaluate(test)];
    train_percents = [train_percents, forest.evaluate(training)];
end

figure(1); hold on;
plot(dataset_sizes, test_percents, 'r-');
plot(dataset_sizes, train_percents, 'b-');
xlabel('Original Dataset Size (90% train, 10% test)');
ylabel('Classification Accuracy');
title('Amount of Training Data');
legend('boxon'); legend('Test', 'Train');
