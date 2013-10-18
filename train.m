clear java;
javaaddpath([pwd '/forests.jar']);
import forests.*;

[vectors, classes] = load_keypoints();
data = forests.Dataset(vectors', classes);
splitted = data.split([0.9 0.1]);
training = splitted(1);
test = splitted(2);

tree = forests.DecisionTree(training);
percentage = tree.evaluate(test);
percentage
