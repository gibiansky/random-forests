

clear java;
javaaddpath([pwd '/forests.jar']);
import forests.*;
%tree = forests.DecisionTree(data);

[vectors, classes] = load_keypoints();
data = forests.Dataset(vectors, classes);
data.numAttributes
data.size