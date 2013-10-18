clear java;
javaaddpath([pwd '/forests.jar']);
import forests.*;

[vectors, classes] = load_keypoints();
data = forests.Dataset(vectors', classes);
splitted = data.split([0.9 0.1]);
training = splitted(1);
test = splitted(2);

tree = forests.DecisionTree(training);
test_percent = tree.evaluate(test);
train_percent = tree.evaluate(training);
disp(sprintf('Single Tree Test: %.2f%%', test_percent));
disp(sprintf('Single Tree Train: %.2f%%', train_percent));

forest = forests.DecisionForest(training, 100, 20);
test_percent = forest.evaluate(test);
train_percent = forest.evaluate(training);
disp(sprintf('100 Tree Forest Test: %.2f%%', test_percent));
disp(sprintf('100 Tree Forest Train: %.2f%%', train_percent));
