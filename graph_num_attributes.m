clear java;
javaaddpath([pwd '/forests.jar']);
import forests.*;

% Load small dataset for testing num trees and attributes.
[vectors, classes] = load_keypoints(250);
data = forests.Dataset(vectors', classes);
splitted = data.split([0.9 0.1]);
training = splitted(1);
test = splitted(2);

% Test num attributes, with num trees fixed to 35.
num_trees = 35;
num_attribute_values = [1 5 10 20 30 35 40 45 50 55 60 80 128];

test_percents = []; train_percents = [];
for num_attributes = num_attribute_values
    forest = forests.DecisionForest(training, num_trees, num_attributes);
    test_percents = [test_percents, forest.evaluate(test)];
    train_percents = [train_percents, forest.evaluate(training)];
    disp(sprintf('Testing num attributes %d.', num_attributes));
end
figure(1); hold on;
plot(num_attribute_values, test_percents, 'r-');
plot(num_attribute_values, train_percents, 'b-');
xlabel('Number of Attributes at each Node');
ylabel('Classification Accuracy');
title('Attribute Subset Size');
legend('boxon'); legend('Test', 'Train');
