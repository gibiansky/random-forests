clear java;
javaaddpath([pwd '/forests.jar']);
import forests.*;

test_percents = []; train_percents = [];

% Test different radii.
radius_values = [5 7 10 12 18 20 25];
for radius = radius_values
    [vectors, classes] = load_keypoints(100, radius);
    data = forests.Dataset(vectors', classes);
    splitted = data.split([0.9 0.1]);
    training = splitted(1);
    test = splitted(2);

    num_trees = 35;
    num_attributes = 30;

    forest = forests.DecisionForest(training, num_trees, num_attributes);
    test_percents = [test_percents, forest.evaluate(test)];
    train_percents = [train_percents, forest.evaluate(training)];
    disp(sprintf('Testing radius %d.', radius));
end

figure(1); hold on;
plot(radius_values, test_percents, 'r-');
plot(radius_values, train_percents, 'b-');
xlabel('Radius in Pixels around Eye Center');
ylabel('Classification Accuracy');
title('Eye Radius');
legend('boxon'); legend('Test', 'Train');
