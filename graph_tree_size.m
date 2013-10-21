clear java;
javaaddpath([pwd '/forests.jar']);
import forests.*;

% Load small dataset for testing num trees and attributes.
[vectors, classes] = load_keypoints(1000);
data = forests.Dataset(vectors', classes);
splitted = data.split([0.9 0.1]);
training = splitted(1);
test = splitted(2);

% Test num trees, with num attributes fixed to 20.
num_tree_values = [1 5 10 20 30 35 40 45 50 55 60 65 75 100 125 150 200];
num_attributes = 20;

test_percents = []; train_percents = [];
for num_trees = num_tree_values
    forest = forests.DecisionForest(training, num_trees, num_attributes);
    test_percents = [test_percents, forest.evaluate(test)];
    train_percents = [train_percents, forest.evaluate(training)];
    disp(sprintf('Testing forest size %d.', num_trees));
end
figure(1); hold on;
plot(num_tree_values, test_percents, 'r-');
plot(num_tree_values, train_percents, 'b-');
xlabel('Number of Trees in Forest');
ylabel('Classification Accuracy');
title('Forest Size');
legend('boxon'); legend('Test', 'Train');

% num trees, num attributes, size of training data, radius
